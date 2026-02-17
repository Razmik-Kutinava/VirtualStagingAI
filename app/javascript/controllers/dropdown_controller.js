import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    // Закрываем меню при клике вне его
    this.boundClickOutside = this.clickOutside.bind(this)
    // Используем capture phase для более надежного отслеживания
    document.addEventListener("click", this.boundClickOutside, true)
  }

  disconnect() {
    document.removeEventListener("click", this.boundClickOutside, true)
  }

  toggle(event) {
    event.stopPropagation()
    event.preventDefault()
    const isHidden = this.menuTarget.classList.contains("hidden")
    
    // Закрываем все другие dropdown меню на странице
    document.querySelectorAll('[data-dropdown-target="menu"]').forEach(menu => {
      if (menu !== this.menuTarget) {
        menu.classList.add("hidden")
      }
    })
    
    // Переключаем текущее меню
    if (isHidden) {
      this.menuTarget.classList.remove("hidden")
      // Устанавливаем очень высокий z-index для меню, чтобы оно было поверх всех элементов
      this.menuTarget.style.zIndex = '99999'
      // Убеждаемся, что родительский контейнер тоже имеет высокий z-index
      if (this.element) {
        this.element.style.zIndex = '10000'
      }
    } else {
      this.menuTarget.classList.add("hidden")
    }
  }

  clickOutside(event) {
    // Проверяем, что клик был вне элемента dropdown
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}

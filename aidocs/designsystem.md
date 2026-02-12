# Дизайн-система VirtualStagingAI

## Обзор

Дизайн-система VirtualStagingAI — это комплексная система компонентов, стилей и руководящих принципов для создания консистентного и профессионального пользовательского интерфейса SaaS продукта виртуального стайлинга интерьеров.

**Версия:** 1.0.0  
**Дата создания:** 2024  
**Статус:** Активная разработка

## Расположение файлов

- **Документация:** `instructions/design_system.md` — полная документация на русском языке
- **CSS реализация:** `app/assets/stylesheets/design_system.css` — готовые стили и компоненты
- **Инструкции:** `instructions/README.md` — краткое руководство по использованию

## Быстрый старт

### Подключение

Дизайн-система уже подключена в `app/assets/stylesheets/application.css`:

```css
@import 'design_system';
```

### Использование компонентов

```erb
<!-- Кнопка -->
<button class="btn-primary">Загрузить изображение</button>

<!-- Карточка -->
<div class="card">
  <h3>Заголовок</h3>
  <p>Описание</p>
</div>

<!-- Форма -->
<input type="text" class="input" placeholder="Введите email">
<textarea class="textarea" placeholder="Сообщение"></textarea>
```

### Использование CSS переменных

```css
.my-component {
  background: var(--primary-500);
  padding: var(--space-4);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-md);
  color: var(--white);
}
```

## Основные компоненты

### Кнопки

- **`.btn-primary`** — Основная кнопка с градиентом
- **`.btn-secondary`** — Вторичная кнопка с обводкой
- **`.btn-ghost`** — Прозрачная кнопка для второстепенных действий

### Карточки

- **`.card`** — Базовая карточка с тенью и hover эффектом
- **`.card-compact`** — Компактная версия
- **`.card-spacious`** — Просторная версия

### Формы

- **`.input`** — Текстовое поле с focus состояниями
- **`.textarea`** — Многострочное текстовое поле

### Badges

- **`.badge-primary`** — Основной badge
- **`.badge-success`** — Успешное действие
- **`.badge-error`** — Ошибка
- **`.badge-warning`** — Предупреждение
- **`.badge-info`** — Информация

## Цветовая палитра

### Primary цвета

- `--primary-500`: #5a67d8 (основной)
- `--primary-600`: #4c51bf (hover)
- `--primary-700`: #434190 (активный)

### Градиенты

- `--gradient-primary`: Основной градиент для кнопок
- `--gradient-hero`: Градиент для hero секций

### Accent цвета

- `--accent-gold`: #f59e0b (премиум элементы)
- `--accent-success`: #10b981 (успех)
- `--accent-error`: #ef4444 (ошибки)

### Нейтральные

- `--gray-50` до `--gray-900`: Полная шкала серых
- `--white`, `--black`: Базовые цвета

## Типографика

### Шрифт

**IBM Plex Sans** — основной шрифт системы

### Размеры

- `--text-6xl`: 3.75rem (60px) — Hero заголовки
- `--text-5xl`: 3rem (48px) — Большие заголовки
- `--text-4xl`: 2.25rem (36px) — Заголовки секций
- `--text-3xl`: 1.875rem (30px) — Подзаголовки
- `--text-2xl`: 1.5rem (24px) — Заголовки карточек
- `--text-xl`: 1.25rem (20px) — Средние заголовки
- `--text-lg`: 1.125rem (18px) — Крупный текст
- `--text-base`: 1rem (16px) — Основной текст
- `--text-sm`: 0.875rem (14px) — Мелкий текст
- `--text-xs`: 0.75rem (12px) — Очень мелкий текст

### Веса

- `--font-light`: 300
- `--font-normal`: 400
- `--font-semibold`: 600
- `--font-bold`: 700
- `--font-extrabold`: 800

## Spacing (Отступы)

Базовая единица: **4px**

- `--space-1`: 0.25rem (4px)
- `--space-2`: 0.5rem (8px)
- `--space-3`: 0.75rem (12px)
- `--space-4`: 1rem (16px)
- `--space-6`: 1.5rem (24px)
- `--space-8`: 2rem (32px)
- `--space-12`: 3rem (48px)
- `--space-16`: 4rem (64px)
- `--space-20`: 5rem (80px)
- `--space-24`: 6rem (96px)

## Тени

- `--shadow-sm`: Тонкие тени
- `--shadow-base`: Базовые тени для карточек
- `--shadow-md`: Средние тени
- `--shadow-lg`: Большие тени для hover
- `--shadow-xl`: Очень большие тени
- `--shadow-2xl`: Максимальные тени

## Border Radius

- `--radius-sm`: 0.25rem (4px)
- `--radius-base`: 0.5rem (8px)
- `--radius-md`: 0.75rem (12px)
- `--radius-lg`: 1rem (16px)
- `--radius-xl`: 1.5rem (24px)
- `--radius-2xl`: 2rem (32px)
- `--radius-full`: 9999px (круг)

## Анимации

### Длительность

- `--duration-fast`: 150ms
- `--duration-base`: 300ms
- `--duration-slow`: 500ms

### Easing

- `--ease-smooth`: cubic-bezier(0.4, 0, 0.2, 1)

### Готовые классы

- `.hover-scale` — Увеличение при hover
- `.fade-in-up` — Появление снизу вверх

## Утилиты

### Градиентные классы

- `.gradient-bg` — Основной градиентный фон
- `.hero-gradient` — Градиент для hero секций

### Контейнеры

- `.container` — Контейнер с max-width 1280px
- `.container-sm` — 640px
- `.container-md` — 768px
- `.container-lg` — 1024px
- `.container-xl` — 1280px

### Навигация

- `.sticky-nav` — Липкая навигация с blur эффектом
- `.nav-link` — Ссылка в навигации

## Breakpoints (Адаптивность)

- `--breakpoint-sm`: 640px (мобильные)
- `--breakpoint-md`: 768px (планшеты)
- `--breakpoint-lg`: 1024px (небольшие десктопы)
- `--breakpoint-xl`: 1280px (большие десктопы)
- `--breakpoint-2xl`: 1536px (очень большие экраны)

## Accessibility (Доступность)

- Все цвета соответствуют WCAG AA стандартам контрастности
- Focus состояния для всех интерактивных элементов
- Семантический HTML
- Поддержка screen readers через `.sr-only` класс

## Примеры использования

### Hero секция

```erb
<section class="hero-gradient text-white py-20">
  <div class="container mx-auto px-4">
    <h1 class="text-5xl md:text-6xl font-bold mb-6">
      Virtual Staging with one click
    </h1>
    <p class="text-xl mb-10 text-gray-100">
      Upload a photo and our AI adds furniture in seconds.
    </p>
    <button class="btn-primary">
      Upload image for free
    </button>
  </div>
</section>
```

### Карточка с иконкой

```erb
<div class="card text-center">
  <div class="gradient-bg w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
    <i class="fas fa-icon text-white text-2xl"></i>
  </div>
  <h3 class="text-xl font-semibold mb-2">Заголовок</h3>
  <p class="text-gray-600">Описание</p>
</div>
```

### Форма

```erb
<form class="space-y-4">
  <div>
    <label class="block text-sm font-medium mb-2">Email</label>
    <input type="email" class="input" placeholder="your@email.com">
  </div>
  <div>
    <label class="block text-sm font-medium mb-2">Сообщение</label>
    <textarea class="textarea" placeholder="Ваше сообщение"></textarea>
  </div>
  <button type="submit" class="btn-primary w-full">
    Отправить
  </button>
</form>
```

## Чеклист при создании компонента

При создании нового компонента убедитесь, что:

- [ ] Используются CSS переменные из дизайн-системы
- [ ] Соответствует цветовой палитре
- [ ] Использует правильные размеры типографики
- [ ] Имеет правильные отступы (spacing)
- [ ] Имеет hover и focus состояния
- [ ] Доступен (accessibility)
- [ ] Адаптивен (responsive)
- [ ] Использует правильные тени
- [ ] Имеет плавные переходы
- [ ] Соответствует общему стилю

## История версий

### Версия 1.0.0 (2024)

- Первоначальный релиз дизайн-системы
- Базовые компоненты (кнопки, карточки, формы)
- Цветовая палитра и типографика
- CSS переменные и утилиты

## Дополнительные ресурсы

- **Полная документация:** `instructions/design_system.md`
- **Краткое руководство:** `instructions/README.md`
- **CSS файл:** `app/assets/stylesheets/design_system.css`

## Поддержка

При возникновении вопросов по использованию дизайн-системы обращайтесь к команде разработки или изучайте полную документацию в `instructions/design_system.md`.

---

## Дополнительные компоненты

### Модальные окна

```erb
<div class="modal-overlay">
  <div class="modal">
    <div class="modal-header">
      <h2>Заголовок</h2>
      <button class="modal-close">&times;</button>
    </div>
    <div class="modal-body">
      <p>Содержимое модального окна</p>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary">Отмена</button>
      <button class="btn-primary">Подтвердить</button>
    </div>
  </div>
</div>
```

### Уведомления (Toast)

```erb
<div class="toast toast-success">
  <span>Операция выполнена успешно</span>
</div>

<div class="toast toast-error">
  <span>Произошла ошибка</span>
</div>
```

### Загрузчики (Loaders)

```erb
<!-- Spinner -->
<div class="spinner"></div>

<!-- Skeleton loader -->
<div class="skeleton skeleton-text"></div>
<div class="skeleton skeleton-avatar"></div>
```

### Таблицы

```erb
<table class="table">
  <thead>
    <tr>
      <th>Заголовок 1</th>
      <th>Заголовок 2</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Данные 1</td>
      <td>Данные 2</td>
    </tr>
  </tbody>
</table>
```

### Вкладки (Tabs)

```erb
<div class="tabs">
  <div class="tabs-list">
    <button class="tab-item active">Вкладка 1</button>
    <button class="tab-item">Вкладка 2</button>
  </div>
  <div class="tabs-content">
    <div class="tab-panel active">Содержимое 1</div>
    <div class="tab-panel">Содержимое 2</div>
  </div>
</div>
```

### Dropdown меню

```erb
<div class="dropdown">
  <button class="dropdown-trigger">Меню</button>
  <div class="dropdown-menu">
    <a href="#" class="dropdown-item">Пункт 1</a>
    <a href="#" class="dropdown-item">Пункт 2</a>
  </div>
</div>
```

---

## Best Practices

### Использование переменных

✅ **Правильно:**

```css
.my-component {
  color: var(--primary-500);
  padding: var(--space-4);
}
```

❌ **Неправильно:**

```css
.my-component {
  color: #5a67d8;
  padding: 16px;
}
```

### Композиция компонентов

✅ **Правильно:** Используйте существующие классы

```erb
<button class="btn-primary">Кнопка</button>
```

❌ **Неправильно:** Создавайте новые классы для того же функционала

```erb
<button class="my-custom-button">Кнопка</button>
```

### Адаптивность

✅ **Правильно:** Mobile-first подход

```css
.component {
  padding: var(--space-4);
}

@media (min-width: 768px) {
  .component {
    padding: var(--space-6);
  }
}
```

### Доступность

✅ **Правильно:** Всегда добавляйте focus состояния

```css
.button:focus {
  outline: 2px solid var(--primary-500);
  outline-offset: 2px;
}
```

---

## FAQ

### Как добавить новый цвет?

Добавьте CSS переменную в `:root` в файле `design_system.css`:

```css
:root {
  --my-new-color: #ff0000;
}
```

### Можно ли использовать Tailwind CSS классы?

Да, если они не конфликтуют с дизайн-системой. Но предпочтительно использовать классы из дизайн-системы для консистентности.

### Как создать новый компонент?

1. Определите, нужен ли он (возможно, можно использовать существующий)
2. Используйте CSS переменные из дизайн-системы
3. Следуйте чеклисту создания компонента
4. Добавьте документацию

### Как изменить основной цвет?

Измените переменные `--primary-500`, `--primary-600`, `--primary-700` в `design_system.css`. Это автоматически обновит все компоненты.

---

## Интеграция с Rails

### Использование в ERB шаблонах

```erb
<%= button_to "Сохранить", save_path, class: "btn-primary" %>
```

### Использование в формах

```erb
<%= form_with model: @model do |f| %>
  <%= f.text_field :email, class: "input" %>
  <%= f.submit "Отправить", class: "btn-primary" %>
<% end %>
```

### Использование в partials

```erb
<!-- app/views/shared/_card.html.erb -->
<div class="card">
  <%= yield %>
</div>
```

---

## Производительность

### Оптимизация CSS

- Используйте только необходимые компоненты
- Минифицируйте CSS в production
- Используйте CSS переменные для динамических изменений (не переопределяйте классы)

### Рекомендации

- Избегайте глубокой вложенности селекторов
- Используйте классы вместо ID для стилизации
- Группируйте связанные стили вместе

---

## Миграция существующих компонентов

При миграции существующих компонентов на дизайн-систему:

1. **Аудит:** Найдите все компоненты, которые нужно обновить
2. **Приоритизация:** Начните с наиболее используемых компонентов
3. **Постепенная замена:** Обновляйте компоненты постепенно
4. **Тестирование:** Проверяйте визуально и функционально после каждого изменения

---

## Полезные ссылки

- [Полная документация](instructions/design_system.md) — детальное описание всех компонентов
- [CSS файл](app/assets/stylesheets/design_system.css) — исходный код стилей
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/) — стандарты доступности

---

## Контрибьютинг

При добавлении новых компонентов или изменении существующих:

1. Обновите документацию
2. Добавьте примеры использования
3. Убедитесь в доступности
4. Протестируйте на разных устройствах
5. Обновите версию в истории версий

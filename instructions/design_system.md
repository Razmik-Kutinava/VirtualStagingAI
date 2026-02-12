# Дизайн-система VirtualStagingAI

## Обзор

Дизайн-система для SaaS продукта виртуального стайлинга интерьеров с помощью AI. Система создана для обеспечения консистентности, доступности и профессионального внешнего вида продукта.

**Целевая аудитория:** Риелторы, агенты по недвижимости, профессионалы в сфере недвижимости.

**Принципы:**
- Профессионализм и доверие
- Современность и инновационность
- Доступность (accessibility)
- Производительность
- Консистентность

---

## 1. Цветовая палитра

### Основные цвета

#### Primary (Основной)
```css
--primary-500: #5a67d8;      /* Основной фиолетовый */
--primary-600: #4c51bf;      /* Более темный фиолетовый */
--primary-700: #434190;      /* Еще темнее для hover */
--primary-800: #3c366b;      /* Самый темный */
```

#### Gradient (Градиент)
```css
--gradient-primary: linear-gradient(135deg, #5a67d8 0%, #6b46c1 50%, #7c3aed 100%);
--gradient-primary-hover: linear-gradient(135deg, #4c51bf 0%, #5b21b6 50%, #6d28d9 100%);
--gradient-hero: linear-gradient(135deg, #5a67d8 0%, #6b46c1 30%, #7c3aed 70%, #8b5cf6 100%);
```

#### Accent (Акцентные цвета)
```css
--accent-gold: #f59e0b;           /* Золотой для премиум элементов */
--accent-gold-light: #fbbf24;     /* Светлый золотой */
--accent-success: #10b981;        /* Зеленый для успеха */
--accent-error: #ef4444;          /* Красный для ошибок */
--accent-warning: #f59e0b;        /* Оранжевый для предупреждений */
--accent-info: #3b82f6;           /* Синий для информации */
```

#### Нейтральные цвета
```css
/* Серые оттенки */
--gray-50: #f9fafb;
--gray-100: #f3f4f6;
--gray-200: #e5e7eb;
--gray-300: #d1d5db;
--gray-400: #9ca3af;
--gray-500: #6b7280;
--gray-600: #4b5563;
--gray-700: #374151;
--gray-800: #1f2937;
--gray-900: #111827;

/* Белый и черный */
--white: #ffffff;
--black: #000000;
```

#### Фоновые цвета
```css
--bg-primary: var(--white);
--bg-secondary: var(--gray-50);
--bg-tertiary: var(--gray-100);
--bg-overlay: rgba(0, 0, 0, 0.6);
--bg-overlay-light: rgba(255, 255, 255, 0.1);
```

### Использование цветов

**Primary используется для:**
- Основных CTA кнопок
- Активных ссылок
- Логотипа и брендинга
- Важных элементов интерфейса

**Accent цвета используются для:**
- Премиум функций (золотой)
- Успешных операций (зеленый)
- Ошибок и предупреждений (красный/оранжевый)
- Информационных сообщений (синий)

**Нейтральные цвета используются для:**
- Текста (gray-600, gray-700, gray-800)
- Фонов (gray-50, gray-100, white)
- Границ и разделителей (gray-200, gray-300)

---

## 2. Типографика

### Шрифт

**Основной шрифт:** IBM Plex Sans
```css
font-family: 'IBM Plex Sans', sans-serif;
```

**Альтернативные варианты:**
- Satoshi (если IBM Plex Sans недоступен)
- Cabinet Grotesk
- Source Sans 3

### Шкала размеров

```css
/* Заголовки */
--text-6xl: 3.75rem;    /* 60px - Hero заголовки */
--text-5xl: 3rem;       /* 48px - Большие заголовки */
--text-4xl: 2.25rem;    /* 36px - Заголовки секций */
--text-3xl: 1.875rem;   /* 30px - Подзаголовки */
--text-2xl: 1.5rem;     /* 24px - Заголовки карточек */
--text-xl: 1.25rem;     /* 20px - Средние заголовки */
--text-lg: 1.125rem;    /* 18px - Крупный текст */
--text-base: 1rem;      /* 16px - Основной текст */
--text-sm: 0.875rem;    /* 14px - Мелкий текст */
--text-xs: 0.75rem;     /* 12px - Очень мелкий текст */
```

### Веса шрифтов

```css
--font-light: 300;      /* Для больших заголовков */
--font-normal: 400;    /* Основной текст */
--font-medium: 500;    /* Подзаголовки */
--font-semibold: 600;  /* Акцентный текст */
--font-bold: 700;       /* Заголовки */
--font-extrabold: 800;  /* Hero заголовки */
```

### Высота строк (Line Height)

```css
--leading-tight: 1.25;    /* Для заголовков */
--leading-normal: 1.5;    /* Для основного текста */
--leading-relaxed: 1.75;  /* Для длинных текстов */
--leading-loose: 2;       /* Для особых случаев */
```

### Примеры использования

```css
/* Hero заголовок */
h1 {
  font-size: var(--text-5xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: -0.02em;
}

/* Заголовок секции */
h2 {
  font-size: var(--text-4xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: -0.02em;
}

/* Основной текст */
p {
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: var(--leading-relaxed);
}

/* Мелкий текст */
small {
  font-size: var(--text-sm);
  font-weight: var(--font-normal);
  line-height: var(--leading-normal);
}
```

---

## 3. Spacing (Отступы)

### Базовая единица: 4px

```css
--space-1: 0.25rem;   /* 4px */
--space-2: 0.5rem;    /* 8px */
--space-3: 0.75rem;   /* 12px */
--space-4: 1rem;      /* 16px */
--space-5: 1.25rem;   /* 20px */
--space-6: 1.5rem;    /* 24px */
--space-8: 2rem;      /* 32px */
--space-10: 2.5rem;   /* 40px */
--space-12: 3rem;     /* 48px */
--space-16: 4rem;     /* 64px */
--space-20: 5rem;     /* 80px */
--space-24: 6rem;     /* 96px */
```

### Использование

- **Внутренние отступы компонентов:** space-4, space-6, space-8
- **Отступы между элементами:** space-4, space-6, space-8
- **Отступы секций:** space-16, space-20, space-24
- **Минимальные отступы:** space-2, space-3

---

## 4. Тени (Shadows)

```css
--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
--shadow-base: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1);
--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
--shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
```

### Использование

- **shadow-sm:** Для тонких границ и разделителей
- **shadow-base:** Для карточек и кнопок
- **shadow-md:** Для карточек при hover
- **shadow-lg:** Для модальных окон и выпадающих меню
- **shadow-xl:** Для hero элементов
- **shadow-2xl:** Для особых акцентов

---

## 5. Border Radius (Скругления)

```css
--radius-sm: 0.25rem;   /* 4px */
--radius-base: 0.5rem;  /* 8px */
--radius-md: 0.75rem;   /* 12px */
--radius-lg: 1rem;      /* 16px */
--radius-xl: 1.5rem;    /* 24px */
--radius-2xl: 2rem;     /* 32px */
--radius-full: 9999px;  /* Полное скругление */
```

### Использование

- **radius-sm:** Для маленьких элементов (badges, tags)
- **radius-base:** Для кнопок и инпутов
- **radius-md:** Для карточек
- **radius-lg:** Для больших карточек
- **radius-xl:** Для hero секций
- **radius-full:** Для аватаров и круглых элементов

---

## 6. Анимации и переходы

### Длительность

```css
--duration-fast: 150ms;
--duration-base: 300ms;
--duration-slow: 500ms;
--duration-slower: 700ms;
```

### Easing функции

```css
--ease-in: cubic-bezier(0.4, 0, 1, 1);
--ease-out: cubic-bezier(0, 0, 0.2, 1);
--ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
--ease-smooth: cubic-bezier(0.4, 0, 0.2, 1);
```

### Стандартные переходы

```css
/* Hover эффекты */
--transition-hover: all var(--duration-base) var(--ease-smooth);

/* Появление элементов */
--transition-fade: opacity var(--duration-base) var(--ease-smooth);

/* Трансформации */
--transition-transform: transform var(--duration-base) var(--ease-smooth);

/* Комбинированный */
--transition-all: all var(--duration-base) var(--ease-smooth);
```

### Анимации

```css
/* Fade in up */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Scale hover */
@keyframes scaleHover {
  from {
    transform: scale(1);
  }
  to {
    transform: scale(1.05);
  }
}

/* Shimmer эффект для кнопок */
@keyframes shimmer {
  0% {
    background-position: -100% 0;
  }
  100% {
    background-position: 100% 0;
  }
}
```

---

## 7. Компоненты

### Кнопки

#### Primary Button
```css
.btn-primary {
  background: var(--gradient-primary);
  color: var(--white);
  padding: var(--space-4) var(--space-6);
  border-radius: var(--radius-lg);
  font-weight: var(--font-semibold);
  font-size: var(--text-base);
  transition: var(--transition-all);
  box-shadow: var(--shadow-md);
}

.btn-primary:hover {
  background: var(--gradient-primary-hover);
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}
```

#### Secondary Button
```css
.btn-secondary {
  background: var(--white);
  color: var(--primary-600);
  padding: var(--space-4) var(--space-6);
  border-radius: var(--radius-lg);
  font-weight: var(--font-semibold);
  font-size: var(--text-base);
  border: 2px solid var(--primary-600);
  transition: var(--transition-all);
}

.btn-secondary:hover {
  background: var(--primary-50);
  transform: translateY(-2px);
}
```

#### Ghost Button
```css
.btn-ghost {
  background: transparent;
  color: var(--gray-600);
  padding: var(--space-4) var(--space-6);
  border-radius: var(--radius-lg);
  font-weight: var(--font-medium);
  transition: var(--transition-all);
}

.btn-ghost:hover {
  color: var(--primary-600);
  background: var(--gray-50);
}
```

### Карточки

```css
.card {
  background: var(--white);
  border-radius: var(--radius-xl);
  padding: var(--space-6);
  box-shadow: var(--shadow-base);
  transition: var(--transition-all);
}

.card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-4px);
}
```

### Формы

#### Input
```css
.input {
  width: 100%;
  padding: var(--space-3) var(--space-4);
  border: 1px solid var(--gray-300);
  border-radius: var(--radius-base);
  font-size: var(--text-base);
  transition: var(--transition-all);
}

.input:focus {
  outline: none;
  border-color: var(--primary-500);
  box-shadow: 0 0 0 3px rgba(90, 103, 216, 0.1);
}
```

#### Textarea
```css
.textarea {
  width: 100%;
  padding: var(--space-3) var(--space-4);
  border: 1px solid var(--gray-300);
  border-radius: var(--radius-base);
  font-size: var(--text-base);
  min-height: 120px;
  resize: vertical;
  transition: var(--transition-all);
}

.textarea:focus {
  outline: none;
  border-color: var(--primary-500);
  box-shadow: 0 0 0 3px rgba(90, 103, 216, 0.1);
}
```

### Навигация

```css
.nav {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  box-shadow: var(--shadow-sm);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-link {
  color: var(--gray-600);
  font-weight: var(--font-medium);
  transition: var(--transition-all);
}

.nav-link:hover {
  color: var(--primary-600);
}
```

### Badges

```css
.badge {
  display: inline-flex;
  align-items: center;
  padding: var(--space-1) var(--space-3);
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  font-weight: var(--font-semibold);
}

.badge-primary {
  background: var(--primary-100);
  color: var(--primary-700);
}

.badge-success {
  background: var(--accent-success);
  color: var(--white);
}
```

---

## 8. Layout (Макет)

### Контейнеры

```css
.container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 var(--space-4);
}

.container-sm {
  max-width: 640px;
}

.container-md {
  max-width: 768px;
}

.container-lg {
  max-width: 1024px;
}

.container-xl {
  max-width: 1280px;
}
```

### Grid система

```css
.grid {
  display: grid;
  gap: var(--space-6);
}

.grid-cols-1 {
  grid-template-columns: repeat(1, minmax(0, 1fr));
}

.grid-cols-2 {
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.grid-cols-3 {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.grid-cols-4 {
  grid-template-columns: repeat(4, minmax(0, 1fr));
}
```

### Flex утилиты

```css
.flex {
  display: flex;
}

.flex-col {
  flex-direction: column;
}

.items-center {
  align-items: center;
}

.justify-between {
  justify-content: space-between;
}

.justify-center {
  justify-content: center;
}

.gap-4 {
  gap: var(--space-4);
}

.gap-6 {
  gap: var(--space-6);
}
```

---

## 9. Breakpoints (Точки останова)

```css
--breakpoint-sm: 640px;   /* Мобильные устройства */
--breakpoint-md: 768px;   /* Планшеты */
--breakpoint-lg: 1024px;  /* Небольшие десктопы */
--breakpoint-xl: 1280px;  /* Большие десктопы */
--breakpoint-2xl: 1536px; /* Очень большие экраны */
```

### Media queries

```css
/* Mobile first подход */
@media (min-width: 640px) { /* sm */ }
@media (min-width: 768px) { /* md */ }
@media (min-width: 1024px) { /* lg */ }
@media (min-width: 1280px) { /* xl */ }
@media (min-width: 1536px) { /* 2xl */ }
```

---

## 10. Z-index шкала

```css
--z-base: 0;
--z-dropdown: 1000;
--z-sticky: 1020;
--z-fixed: 1030;
--z-modal-backdrop: 1040;
--z-modal: 1050;
--z-popover: 1060;
--z-tooltip: 1070;
```

---

## 11. Accessibility (Доступность)

### Цветовой контраст

- Все тексты должны иметь контраст минимум 4.5:1 (WCAG AA)
- Для крупного текста (18px+) минимум 3:1
- Интерактивные элементы должны иметь визуальный индикатор фокуса

### Focus состояния

```css
.focus-ring {
  outline: 2px solid transparent;
  outline-offset: 2px;
}

.focus-ring:focus {
  outline: 2px solid var(--primary-500);
  outline-offset: 2px;
}
```

### ARIA атрибуты

- Использовать семантический HTML
- Добавлять aria-label для иконок без текста
- Использовать aria-expanded для выпадающих меню
- Использовать role="button" для элементов, которые ведут себя как кнопки

---

## 12. Примеры использования

### Hero секция

```html
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

### Карточка

```html
<div class="card">
  <div class="gradient-bg w-16 h-16 rounded-full flex items-center justify-center mb-4">
    <i class="fas fa-icon text-white text-2xl"></i>
  </div>
  <h3 class="text-xl font-semibold mb-2">Заголовок</h3>
  <p class="text-gray-600">Описание</p>
</div>
```

### Форма

```html
<form class="space-y-4">
  <div>
    <label class="block text-sm font-medium mb-2">Email</label>
    <input type="email" class="input" placeholder="your@email.com">
  </div>
  <button type="submit" class="btn-primary w-full">
    Отправить
  </button>
</form>
```

---

## 13. Имплементация в CSS

### Создание файла design-system.css

```css
:root {
  /* Цвета */
  --primary-500: #5a67d8;
  --primary-600: #4c51bf;
  /* ... все остальные переменные ... */
  
  /* Типографика */
  --text-base: 1rem;
  /* ... все остальные переменные ... */
  
  /* Spacing */
  --space-4: 1rem;
  /* ... все остальные переменные ... */
}

/* Базовые стили */
* {
  font-family: 'IBM Plex Sans', sans-serif;
  line-height: 1.6;
}

/* Компоненты */
.btn-primary { /* ... */ }
.card { /* ... */ }
/* ... все остальные компоненты ... */
```

---

## 14. Чеклист использования

При создании нового компонента проверьте:

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

---

## 15. Обновления и версионирование

**Версия:** 1.0.0
**Дата создания:** 2024
**Последнее обновление:** 2024

При внесении изменений в дизайн-систему:
1. Обновите версию
2. Задокументируйте изменения
3. Уведомите команду
4. Обновите примеры использования

---

## Контакты и вопросы

При возникновении вопросов по использованию дизайн-системы обращайтесь к команде разработки.

# Дизайн-система VirtualStagingAI — НЕОНОВЫЙ СТИЛЬ

## Обзор

Дизайн-система VirtualStagingAI построена на агрессивном неоновом стиле с элементами киберпанка и ретрофутуризма. Система создана для создания яркого, запоминающегося интерфейса SaaS продукта виртуального стайлинга интерьеров.

**Философия дизайна:** "ТОЛЬКО НЕОН. ТОЛЬКО ХАРД."

**Версия:** 2.0.0 (Neon Edition)  
**Дата создания:** 2024  
**Статус:** Активная разработка

---

## 1. Цветовая палитра

### Основные неоновые цвета

```css
:root {
  /* НЕОНОВЫЕ ЦВЕТА */
  --pink: #ff3b7f;           /* Неоновый розовый — основной акцент */
  --cyan: #00f7f6;           /* Неоновый циан — вторичный акцент */
  --yellow: #ffe600;         /* Неоновый желтый — акцент действия */
  --magenta: #c724b1;       /* Пурпурный — для hover состояний */
  
  /* ФОНОВЫЕ ЦВЕТА */
  --chrome: #0b0d10;         /* Основной темный фон */
  --chrome-dark: #0e0f14;    /* Более темный вариант */
  --chrome-light: #0f1116;   /* Светлее для секций */
  --chrome-lighter: #12161c; /* Еще светлее для карточек */
  --chrome-card: #1a1d24;    /* Фон карточек */
  
  /* ТЕКСТУРНЫЕ ЦВЕТА */
  --film: #f2e9d2;           /* Цвет старой пленки (для акцентов) */
}
```

### Использование цветов

**Неоновый розовый (`--pink`):**
- Основные CTA кнопки
- Границы карточек
- Акцентные элементы
- Тени и свечение
- Логотип и брендинг

**Неоновый циан (`--cyan`):**
- Вторичные кнопки
- Hover состояния навигации
- Акцентные заголовки
- Границы элементов

**Неоновый желтый (`--yellow`):**
- Главные действия (загрузка, регистрация)
- Статистика и цифры
- Выделение важной информации
- Границы важных элементов

**Пурпурный (`--magenta`):**
- Hover состояния кнопок
- Альтернативные акценты
- Градиенты

---

## 2. Типографика

### Шрифт

**Основной шрифт:** Space Grotesk
```css
font-family: 'Space Grotesk', sans-serif;
```

**Характеристики:**
- Геометрический гротеск с характером
- Отлично читается в неоновом стиле
- Поддерживает веса: 400, 500, 600, 700, 800

### Размеры

```css
/* Заголовки */
--text-7xl: 4.5rem;    /* 72px - Hero заголовки */
--text-6xl: 3.75rem;   /* 60px - Большие заголовки */
--text-5xl: 3rem;      /* 48px - Заголовки секций */
--text-4xl: 2.25rem;   /* 36px - Подзаголовки */
--text-3xl: 1.875rem;  /* 30px - Заголовки карточек */
--text-2xl: 1.5rem;    /* 24px - Средние заголовки */
--text-xl: 1.25rem;    /* 20px - Крупный текст */
--text-lg: 1.125rem;   /* 18px - Увеличенный текст */
--text-base: 1rem;     /* 16px - Основной текст */
--text-sm: 0.875rem;   /* 14px - Мелкий текст */
--text-xs: 0.75rem;    /* 12px - Очень мелкий текст */
```

### Веса шрифтов

```css
--font-normal: 400;    /* Основной текст */
--font-medium: 500;    /* Подзаголовки */
--font-semibold: 600;  /* Акцентный текст */
--font-bold: 700;      /* Заголовки */
--font-black: 800;     /* Hero заголовки, логотип */
```

### Letter Spacing (Межбуквенное расстояние)

```css
--tracking-tight: -0.03em;   /* Для больших заголовков */
--tracking-normal: -0.01em;  /* Для основного текста */
--tracking-wide: 0.05em;     /* Для uppercase текста */
--tracking-widest: 0.25em;   /* Для кнопок и акцентов */
```

### Неоновое свечение текста

```css
/* Неоновое свечение розовым */
.neon-pink {
  color: var(--pink);
  text-shadow: 0 0 8px var(--pink), 0 0 20px rgba(255, 59, 127, 0.5);
}

/* Неоновое свечение цианом */
.neon-cyan {
  color: var(--cyan);
  text-shadow: 0 0 8px var(--cyan), 0 0 20px rgba(0, 247, 246, 0.4);
}

/* Неоновое свечение желтым */
.neon-yellow {
  color: var(--yellow);
  text-shadow: 0 0 8px var(--yellow), 0 0 20px rgba(255, 230, 0, 0.4);
}

/* Тень со смещением для логотипа */
.logo-shadow {
  text-shadow: 2px 2px 0 var(--pink);
}
```

### Примеры использования

```css
/* Hero заголовок */
h1 {
  font-size: var(--text-6xl);
  font-weight: var(--font-black);
  letter-spacing: var(--tracking-tight);
  text-transform: uppercase;
  line-height: 1.1;
}

/* Заголовок секции */
h2 {
  font-size: var(--text-5xl);
  font-weight: var(--font-black);
  letter-spacing: var(--tracking-tight);
  text-transform: uppercase;
}

/* Основной текст */
p {
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  letter-spacing: var(--tracking-normal);
  color: rgba(255, 255, 255, 0.8);
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

- **Секции:** `py-20` (80px вертикальные отступы)
- **Карточки:** `p-6` (24px внутренние отступы)
- **Кнопки:** `px-10 py-5` (40px горизонтально, 20px вертикально)
- **Навигация:** `py-3 px-4` (12px вертикально, 16px горизонтально)
- **Между элементами:** `gap-6`, `gap-8` (24px, 32px)

---

## 4. Тени и эффекты

### Тени со смещением (Box Shadows)

**Философия:** Тени создают эффект "выдавленных" элементов, как в ретро-дизайне.

```css
/* Тень желтого на розовый */
--shadow-yellow-pink: 6px 6px 0 var(--pink);
--shadow-yellow-pink-hover: 3px 3px 0 var(--magenta);

/* Тень розового на желтый */
--shadow-pink-yellow: 4px 4px 0 var(--yellow);

/* Тень циана на розовый */
--shadow-cyan-pink: 6px 6px 0 var(--pink);

/* Тень розового на циан */
--shadow-pink-cyan: 10px 10px 0 var(--cyan);

/* Тень желтого на циан */
--shadow-yellow-cyan: 8px 8px 0 var(--cyan);

/* Многослойные тени для карточек */
--shadow-card: 0 20px 35px -10px rgba(0,0,0,0.8);
--shadow-card-hover: 0 25px 40px -12px rgba(255, 59, 127, 0.5), 0 0 0 1px var(--pink) inset;

/* Тени для навигации */
--shadow-nav: 4px 4px 0 var(--pink);
```

### Неоновое свечение (Glow)

```css
/* Свечение розовым */
--glow-pink: 0 0 8px var(--pink), 0 0 20px rgba(255, 59, 127, 0.5);

/* Свечение цианом */
--glow-cyan: 0 0 8px var(--cyan), 0 0 20px rgba(0, 247, 246, 0.4);

/* Свечение желтым */
--glow-yellow: 0 0 8px var(--yellow), 0 0 20px rgba(255, 230, 0, 0.4);

/* Свечение для границ */
--glow-border-pink: 0 0 15px var(--pink);
--glow-border-cyan: 0 0 15px var(--cyan);
--glow-border-yellow: 0 0 15px var(--yellow);
```

---

## 5. Border Radius (Скругления)

**Философия:** Минимальные скругления, острые углы для агрессивного вида.

```css
--radius-none: 0;           /* Без скругления */
--radius-sm: 2px;           /* Минимальное скругление */
--radius-base: 4px;         /* Базовое скругление */
--radius-md: 8px;           /* Среднее скругление */
--radius-lg: 12px;          /* Большое скругление */
```

**Использование:**
- Кнопки: `border-radius: 2px` (почти квадратные)
- Карточки: без скругления или минимальное
- Инпуты: `border-radius: 2px`

---

## 6. Границы (Borders)

### Толщина границ

```css
--border-thin: 1px;
--border-base: 2px;
--border-thick: 3px;
--border-thicker: 4px;
```

### Стили границ

```css
/* Неоновые границы */
.border-neon-pink {
  border: 2px solid var(--pink);
}

.border-neon-cyan {
  border: 2px solid var(--cyan);
}

.border-neon-yellow {
  border: 3px solid var(--yellow);
  outline: 1px solid black;
  outline-offset: -4px;
}

/* Границы с прозрачностью */
.border-pink-transparent {
  border-bottom: 1px solid rgba(255, 59, 127, 0.5);
}

.border-cyan-transparent {
  border: 1px solid rgba(0, 247, 246, 0.3);
}
```

---

## 7. Компоненты

### Кнопки

#### Кнопка-вспышка (Flash Button) — основная CTA

```css
.btn-flash {
  background: var(--yellow);
  color: var(--chrome);
  font-weight: var(--font-bold);
  text-transform: uppercase;
  letter-spacing: 2px;
  border-radius: 2px;
  box-shadow: 6px 6px 0 var(--pink);
  transition: 0.1s linear;
  border: none;
  padding: var(--space-5) var(--space-10);
  font-size: var(--text-lg);
}

.btn-flash:hover {
  background: #fff150;
  box-shadow: 3px 3px 0 var(--magenta);
  transform: translate(3px, 3px);
}
```

**Использование:**
```html
<a href="#" class="btn-flash px-10 py-5 text-lg">
  📸 Загрузить бесплатно
</a>
```

#### Кнопка циановая

```css
.btn-cyan {
  background: var(--cyan);
  color: var(--chrome);
  box-shadow: 6px 6px 0 var(--pink);
  font-weight: var(--font-bold);
  letter-spacing: 2px;
  text-transform: uppercase;
  border-radius: 2px;
  padding: var(--space-5) var(--space-10);
}
```

#### Кнопка розовая (Регистрация)

```css
.btn-pink {
  background: var(--pink);
  color: var(--white);
  box-shadow: 4px 4px 0 var(--yellow);
  font-weight: var(--font-bold);
  text-transform: uppercase;
  letter-spacing: 0.25em;
  padding: var(--space-3) var(--space-5);
}

.btn-pink:hover {
  box-shadow: 2px 2px 0 var(--yellow);
  transform: translate(1px, 1px);
}
```

### Карточки

#### Базовая карточка (Print Card)

```css
.print-card {
  background: var(--chrome-lighter);
  border: 1px solid #2a2e38;
  box-shadow: var(--shadow-card);
  transition: border 0.2s, box-shadow 0.3s, transform 0.25s cubic-bezier(0.2, 0.95, 0.4, 1);
  padding: var(--space-6);
}

.print-card:hover {
  border: 1px solid var(--pink);
  box-shadow: var(--shadow-card-hover);
  transform: translateY(-6px) scale(1.01);
}
```

#### Карточка с неоновой границей

```css
.card-neon-yellow {
  background: var(--chrome-light);
  border: 2px solid var(--yellow);
  box-shadow: 10px 10px 0 var(--pink);
}

.card-neon-cyan {
  background: var(--chrome-light);
  border: 2px solid var(--cyan);
  box-shadow: 10px 10px 0 var(--yellow);
}

.card-neon-pink {
  background: var(--chrome-light);
  border: 2px solid var(--pink);
  box-shadow: 10px 10px 0 var(--cyan);
}
```

#### Карточка с цветной верхней границей

```css
.card-top-border-pink {
  border-top: 4px solid var(--pink);
}

.card-top-border-cyan {
  border-top: 4px solid var(--cyan);
}

.card-top-border-yellow {
  border-top: 4px solid var(--yellow);
}
```

### Навигация

#### Sticky Navigation

```css
.nav-sticky {
  position: sticky;
  top: 0;
  z-index: 100;
  background: rgba(11, 13, 16, 0.85);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(255, 59, 127, 0.5);
  padding: var(--space-3) var(--space-4);
}
```

#### Навигационные ссылки

```css
.nav-link {
  position: relative;
  display: inline-block;
  text-decoration: none;
  user-select: none;
  pointer-events: auto !important;
  cursor: pointer !important;
  z-index: 10;
  color: rgba(255, 255, 255, 0.8);
  font-weight: var(--font-bold);
  text-transform: uppercase;
  font-size: var(--text-sm);
  letter-spacing: var(--tracking-wide);
  padding: var(--space-2) var(--space-1);
  transition: all 0.2s;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--cyan);
  transition: width 0.3s ease;
  box-shadow: 0 0 8px var(--cyan);
}

.nav-link:hover {
  color: var(--cyan) !important;
  text-shadow: 0 0 8px var(--cyan);
  transform: translateY(-1px);
}

.nav-link:hover::after {
  width: 100%;
}

.nav-link:active {
  transform: translateY(0);
  color: var(--yellow) !important;
  text-shadow: 0 0 12px var(--yellow);
}

.nav-link:active::after {
  background: var(--yellow);
  box-shadow: 0 0 12px var(--yellow);
}
```

### Статистика

#### Большие цифры со свечением

```css
.stat-num {
  color: var(--yellow);
  font-size: 5rem;
  font-weight: var(--font-black);
  line-height: 1;
  text-shadow: 5px 5px 0 var(--pink), 8px 8px 0 rgba(0, 247, 246, 0.3);
}
```

### Логотип

```css
.logo {
  display: flex;
  align-items: center;
  gap: var(--space-3);
}

.logo-icon {
  width: 36px;
  height: 36px;
  background: var(--yellow);
  transform: rotate(12deg);
  box-shadow: 4px 4px 0 var(--pink);
}

.logo-text {
  font-size: var(--text-2xl);
  font-weight: var(--font-black);
  color: var(--white);
  letter-spacing: var(--tracking-tight);
  text-shadow: 2px 2px 0 var(--pink);
}
```

---

## 8. Фоновые эффекты

### Текстурный шум (Film Grain)

```css
body::before {
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><filter id="noise"><feTurbulence type="fractalNoise" baseFrequency="0.85" numOctaves="1"/><feColorMatrix type="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0.15 0"/></filter><rect width="100" height="100" filter="url(%23noise)" opacity="0.045"/></svg>');
  opacity: 0.3;
  pointer-events: none;
  z-index: 9999;
  mix-blend-mode: overlay;
}
```

### VHS Overlay (Сканирующие линии)

```css
.vhs-overlay {
  background: repeating-linear-gradient(
    0deg,
    rgba(0, 0, 0, 0.2) 0px,
    rgba(255, 255, 255, 0.02) 1px,
    transparent 2px
  );
  pointer-events: none;
}
```

### Неоновые пятна (Ambient Glow)

```css
.ambient-glow-pink {
  background: var(--pink);
  border-radius: 50%;
  mix-blend-mode: multiply;
  filter: blur(100px);
  opacity: 0.2;
  animation: pulse 3s ease-in-out infinite;
}

.ambient-glow-cyan {
  background: var(--cyan);
  border-radius: 50%;
  mix-blend-mode: multiply;
  filter: blur(90px);
  opacity: 0.2;
}
```

### Градиентные фоны секций

```css
.bg-hero {
  background: radial-gradient(circle at 80% 20%, #1a1022, var(--chrome));
}

.bg-section-dark {
  background: var(--chrome-dark);
}

.bg-section-light {
  background: var(--chrome-light);
}
```

---

## 9. Анимации и переходы

### Длительность

```css
--duration-fast: 100ms;    /* Мгновенные эффекты (клики) */
--duration-base: 200ms;     /* Базовые переходы */
--duration-slow: 300ms;     /* Медленные переходы */
--duration-slower: 500ms;   /* Очень медленные */
```

### Easing функции

```css
--ease-linear: linear;
--ease-smooth: cubic-bezier(0.2, 0.95, 0.4, 1);
--ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### Стандартные переходы

```css
.transition-all {
  transition: all var(--duration-base) var(--ease-smooth);
}

.transition-hover {
  transition: border 0.2s, box-shadow 0.3s, transform 0.25s var(--ease-smooth);
}
```

### Анимации

```css
@keyframes pulse {
  0%, 100% {
    opacity: 0.2;
  }
  50% {
    opacity: 0.3;
  }
}

.animate-pulse {
  animation: pulse 3s ease-in-out infinite;
}
```

---

## 10. Layout (Макет)

### Контейнеры

```css
.container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 var(--space-4);
}

.container-narrow {
  max-width: 1024px;
}

.container-wide {
  max-width: 1536px;
}
```

### Grid система

```css
.grid {
  display: grid;
  gap: var(--space-6);
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

.grid-cols-5 {
  grid-template-columns: repeat(5, minmax(0, 1fr));
}
```

---

## 11. Breakpoints (Адаптивность)

```css
--breakpoint-sm: 640px;   /* Мобильные устройства */
--breakpoint-md: 768px;   /* Планшеты */
--breakpoint-lg: 1024px; /* Небольшие десктопы */
--breakpoint-xl: 1280px; /* Большие десктопы */
```

**Использование:**
- Навигация скрыта на мобильных: `hidden md:flex`
- Заголовки уменьшаются: `text-6xl md:text-7xl`
- Grid адаптируется: `grid-cols-1 md:grid-cols-2 lg:grid-cols-3`

---

## 12. Z-index шкала

```css
--z-base: 0;
--z-content: 10;
--z-nav: 100;
--z-modal: 1000;
--z-overlay: 9999;
```

---

## 13. Примеры использования

### Hero секция

```html
<section class="relative py-20 px-4 overflow-hidden bg-hero">
  <div class="container mx-auto max-w-6xl">
    <h1 class="text-6xl md:text-7xl font-black uppercase">
      <span class="neon-pink">СТАЙЛИНГ</span><br/>
      <span class="text-white">ЗА</span> 
      <span class="neon-cyan">15 СЕКУНД</span>
    </h1>
    <a href="#" class="btn-flash px-10 py-5 text-lg">
      📸 Загрузить бесплатно
    </a>
  </div>
</section>
```

### Карточка с неоновой границей

```html
<div class="print-card card-neon-yellow p-6">
  <span class="text-4xl mb-3">💰</span>
  <h3 class="text-lg font-bold text-white">$9/ФОТО</h3>
  <p class="text-white/60 text-sm">дешевле аренды</p>
</div>
```

### Навигация

```html
<nav class="nav-sticky">
  <div class="container mx-auto flex justify-between items-center">
    <div class="logo">
      <div class="logo-icon"></div>
      <span class="logo-text">VSAI</span>
    </div>
    <div class="hidden md:flex items-center space-x-8">
      <a href="#gallery" class="nav-link">Галерея</a>
      <a href="#styles" class="nav-link">Стили</a>
      <a href="#how" class="nav-link">Как работает</a>
    </div>
  </div>
</nav>
```

---

## 14. Best Practices

### Использование неоновых эффектов

✅ **Правильно:** Используйте неоновые цвета для акцентов и важных элементов
```css
.important-text {
  color: var(--cyan);
  text-shadow: 0 0 8px var(--cyan);
}
```

❌ **Неправильно:** Не перегружайте интерфейс неоном везде
```css
.everything-neon {
  /* Слишком много неона */
}
```

### Тени со смещением

✅ **Правильно:** Используйте тени для создания глубины
```css
.button {
  box-shadow: 6px 6px 0 var(--pink);
}
```

❌ **Неправильно:** Не используйте стандартные тени
```css
.button {
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
```

### Контрастность

✅ **Правильно:** Темный фон с яркими акцентами
```css
.section {
  background: var(--chrome);
  color: var(--white);
}
```

---

## 15. Чеклист использования

При создании компонента проверьте:

- [ ] Используются неоновые цвета из палитры
- [ ] Добавлено неоновое свечение для важных элементов
- [ ] Используются тени со смещением
- [ ] Минимальные скругления углов
- [ ] Темный фон с яркими акцентами
- [ ] Агрессивная типографика (uppercase, bold)
- [ ] Hover эффекты с трансформациями
- [ ] Текстурный шум на фоне
- [ ] Адаптивность для мобильных устройств

---

## 16. История версий

### Версия 2.0.0 (Neon Edition) — 2024
- Полная переработка на неоновый стиль
- Новые компоненты с неоновыми эффектами
- Агрессивная типографика
- Тени со смещением
- Текстурные эффекты

---

## 17. ДАШБОРД D3 - ОТДЕЛЬНАЯ ДИЗАЙН-СИСТЕМА

### Обзор

Дашборд использует отдельную дизайн-систему D3 с техно-эстетикой и неоновым цианом. Система создана специально для интерфейса управления проектами и фотографиями.

**Версия:** 3.0.0 (Dashboard D3)  
**Статус:** Активная

### Цветовая палитра D3

```css
:root {
  /* Основные фоны */
  --d3-ink: #03050a;              /* Главный фон страницы */
  --d3-panel-deep: #0b0e14;      /* Фон сайдбара, глубокие панели */
  --d3-panel-raise: #12161e;      /* Карточки, всплывающие панели, хедер */
  
  /* Границы и разделители */
  --d3-border-sharp: #1e2632;     /* Все рамки, бордеры, разделители */
  
  /* Акцентные цвета */
  --d3-accent-electric: #00e0ff;  /* Основной акцент (неон-циан) */
  --d3-accent-blue: #2f6cff;      /* Вторичный акцент (глубокий синий) */
  
  /* Текст */
  --d3-text-primary: #ffffff;     /* Основной текст, заголовки */
  --d3-text-secondary: #a0b3d9;   /* Второстепенный текст, подписи */
  --d3-text-muted: #62748c;      /* Неактивный текст, счётчики, метки */
  
  /* Свечение */
  --d3-glow-electric: rgba(0, 224, 255, 0.35);
  --d3-glow-blue: rgba(47, 108, 255, 0.25);
}
```

### Типографика D3

**Шрифт:** Inter, sans-serif

**Характеристики:**
- Основная толщина: 400 (regular), 500 (medium), 600 (semibold)
- Заголовки: 600 (semibold)
- Акцентный текст: color: var(--d3-accent-electric) + text-shadow
- Кернинг: letter-spacing: -0.01em (по умолчанию)
- Uppercase: Только для кнопок и мелких меток (с доп. letter-spacing: 1px)

### Фоновые текстуры D3

#### Техно-сетка

```css
.d3-tech-grid::before {
  content: "";
  position: fixed;
  top: 0; left: 0; width: 100vw; height: 100vh;
  background-image: 
    linear-gradient(var(--d3-border-sharp) 1px, transparent 1px),
    linear-gradient(90deg, var(--d3-border-sharp) 1px, transparent 1px);
  background-size: 48px 48px;
  opacity: 0.2;
  pointer-events: none;
  z-index: 9998;
}
```

#### Сканирующая линия

```css
.d3-scan-line::after {
  content: "";
  position: fixed;
  top: 0; left: 0; width: 100%; height: 100%;
  background: repeating-linear-gradient(0deg, 
    rgba(0,224,255,0) 0px, 
    rgba(0,224,255,0.02) 2px, 
    transparent 4px
  );
  pointer-events: none;
  z-index: 9999;
  opacity: 0.3;
}
```

### Компоненты D3

#### Карточки

```css
.d3-card {
  background: var(--d3-panel-raise);
  border: 1px solid var(--d3-border-sharp);
  box-shadow: 0 20px 35px -15px rgba(0,0,0,0.8);
  transition: border 0.2s, box-shadow 0.3s, transform 0.15s;
  border-radius: 0;
}

.d3-card:hover {
  border: 1px solid var(--d3-accent-electric);
  box-shadow: 0 25px 40px -20px var(--d3-glow-electric);
  transform: translateY(-2px);
}
```

#### Кнопки

**Solid (основная):**
```css
.d3-btn-solid {
  background: var(--d3-accent-blue);
  color: var(--d3-text-primary);
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 1px;
  border-radius: 0;
  box-shadow: 0 6px 0 #001a4f;
  transition: 0.1s linear;
}

.d3-btn-solid:hover {
  transform: translateY(2px);
  box-shadow: 0 4px 0 #001a4f;
}
```

**Outlined (контурная):**
```css
.d3-btn-outlined {
  background: transparent;
  color: var(--d3-accent-electric);
  border: 2px solid var(--d3-accent-electric);
  font-weight: 600;
  letter-spacing: 1px;
  text-transform: uppercase;
  border-radius: 0;
  transition: all 0.2s;
}

.d3-btn-outlined:hover {
  background: var(--d3-accent-electric);
  color: var(--d3-ink);
  box-shadow: 0 0 25px var(--d3-glow-electric);
}
```

#### Прогресс-бары

```css
.d3-progress-track {
  background: #1a212c;
  height: 6px;
  border-radius: 0;
}

.d3-progress-fill {
  background: var(--d3-accent-electric);
  height: 6px;
  box-shadow: 0 0 12px var(--d3-accent-electric);
  border-radius: 0;
}
```

#### Бейджи

```css
.d3-badge {
  background: rgba(0,224,255,0.08);
  border: 1px solid rgba(0,224,255,0.3);
  color: var(--d3-accent-electric);
  font-size: 0.65rem;
  font-weight: 600;
  padding: 0.25rem 0.75rem;
  letter-spacing: 1px;
  text-transform: uppercase;
  border-radius: 0;
}
```

#### Пагинация

```css
.d3-pagination {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid var(--d3-border-sharp);
  color: var(--d3-text-secondary);
  transition: 0.1s;
  border-radius: 0;
}

.d3-pagination:hover,
.d3-pagination.active {
  border-color: var(--d3-accent-electric);
  color: var(--d3-accent-electric);
  background: rgba(0,224,255,0.05);
}
```

#### Разделители

```css
.d3-divider {
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--d3-accent-electric), transparent);
  opacity: 0.3;
}
```

#### Скроллбар

```css
.d3-scrollbar::-webkit-scrollbar {
  width: 5px;
}

.d3-scrollbar::-webkit-scrollbar-track {
  background: var(--d3-panel-deep);
}

.d3-scrollbar::-webkit-scrollbar-thumb {
  background: var(--d3-accent-blue);
}

.d3-scrollbar::-webkit-scrollbar-thumb:hover {
  background: var(--d3-accent-electric);
}
```

### Скругления D3

**Все элементы:** `border-radius: 0` (прямые углы)

### Анимации и переходы D3

```css
/* Для карточек */
transition: border 0.2s, box-shadow 0.3s, transform 0.15s;

/* Для кнопок */
transition: 0.1s linear;

/* Ховер карточек */
transform: translateY(-2px);

/* Ховер кнопок с тенью-сдвигом */
transform: translateY(2px);
```

### Использование D3

Дашборд D3 применяется только к интерфейсу управления проектами (`/dashboard`). Все компоненты используют префикс `d3-` для избежания конфликтов с основной дизайн-системой.

**Пример:**
```html
<div class="d3-card">
  <h2 class="d3-neon-electric">Заголовок</h2>
  <button class="d3-btn-outlined">Действие</button>
</div>
```

---

## Контакты

При возникновении вопросов по использованию дизайн-системы обращайтесь к команде разработки.

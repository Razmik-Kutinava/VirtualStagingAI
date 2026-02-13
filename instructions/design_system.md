# Дизайн-система VirtualStagingAI — НЕОНОВЫЙ СТИЛЬ

## Обзор

Дизайн-система VirtualStagingAI построена на агрессивном неоновом стиле с элементами киберпанка и ретрофутуризма. Система создана для создания яркого, запоминающегося интерфейса SaaS продукта виртуального стайлинга интерьеров.

**Философия дизайна:** "ТОЛЬКО НЕОН. ТОЛЬКО ХАРД."

**Целевая аудитория:** Риелторы, агенты по недвижимости, профессионалы в сфере недвижимости.

**Принципы:**
- Агрессивность и яркость
- Неоновые акценты везде
- Минимальные скругления
- Тени со смещением
- Темный фон с яркими элементами
- Консистентность неоновой палитры

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
- Навигационные акценты

**Неоновый циан (`--cyan`):**
- Вторичные кнопки
- Hover состояния навигации
- Акцентные заголовки
- Границы элементов
- Подчеркивания ссылок

**Неоновый желтый (`--yellow`):**
- Главные действия (загрузка, регистрация)
- Статистика и цифры
- Выделение важной информации
- Границы важных элементов
- Логотип

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

### Letter Spacing

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

---

## 4. Тени и эффекты

### Тени со смещением

```css
/* Тень желтого на розовый */
--shadow-yellow-pink: 6px 6px 0 var(--pink);
--shadow-yellow-pink-hover: 3px 3px 0 var(--magenta);

/* Тень розового на желтый */
--shadow-pink-yellow: 4px 4px 0 var(--yellow);

/* Тень циана на розовый */
--shadow-cyan-pink: 6px 6px 0 var(--pink);

/* Многослойные тени для карточек */
--shadow-card: 0 20px 35px -10px rgba(0,0,0,0.8);
--shadow-card-hover: 0 25px 40px -12px rgba(255, 59, 127, 0.5), 0 0 0 1px var(--pink) inset;
```

### Неоновое свечение

```css
--glow-pink: 0 0 8px var(--pink), 0 0 20px rgba(255, 59, 127, 0.5);
--glow-cyan: 0 0 8px var(--cyan), 0 0 20px rgba(0, 247, 246, 0.4);
--glow-yellow: 0 0 8px var(--yellow), 0 0 20px rgba(255, 230, 0, 0.4);
```

---

## 5. Border Radius

```css
--radius-none: 0;           /* Без скругления */
--radius-sm: 2px;           /* Минимальное скругление */
--radius-base: 4px;         /* Базовое скругление */
```

---

## 6. Компоненты

### Кнопки

#### Кнопка-вспышка (Flash Button)

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
}

.btn-flash:hover {
  background: #fff150;
  box-shadow: 3px 3px 0 var(--magenta);
  transform: translate(3px, 3px);
}
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
}
```

### Карточки

#### Базовая карточка

```css
.print-card {
  background: var(--chrome-lighter);
  border: 1px solid #2a2e38;
  box-shadow: var(--shadow-card);
  transition: border 0.2s, box-shadow 0.3s, transform 0.25s cubic-bezier(0.2, 0.95, 0.4, 1);
}

.print-card:hover {
  border: 1px solid var(--pink);
  box-shadow: var(--shadow-card-hover);
  transform: translateY(-6px) scale(1.01);
}
```

### Навигация

#### Навигационные ссылки

```css
.nav-link {
  position: relative;
  display: inline-block;
  color: rgba(255, 255, 255, 0.8);
  font-weight: var(--font-bold);
  text-transform: uppercase;
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
```

---

## 7. Фоновые эффекты

### Текстурный шум

```css
body::before {
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-image: url('data:image/svg+xml,...');
  opacity: 0.3;
  pointer-events: none;
  z-index: 9999;
  mix-blend-mode: overlay;
}
```

### VHS Overlay

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

---

## 8. Анимации

### Длительность

```css
--duration-fast: 100ms;
--duration-base: 200ms;
--duration-slow: 300ms;
```

### Easing

```css
--ease-linear: linear;
--ease-smooth: cubic-bezier(0.2, 0.95, 0.4, 1);
```

---

## 9. Layout

### Контейнеры

```css
.container {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 var(--space-4);
}
```

---

## 10. Breakpoints

```css
--breakpoint-sm: 640px;
--breakpoint-md: 768px;
--breakpoint-lg: 1024px;
--breakpoint-xl: 1280px;
```

---

## 11. Примеры использования

### Hero секция

```html
<section class="relative py-20 px-4 bg-hero">
  <h1 class="text-6xl font-black uppercase">
    <span class="neon-pink">СТАЙЛИНГ</span>
    <span class="neon-cyan">ЗА 15 СЕКУНД</span>
  </h1>
  <a href="#" class="btn-flash">Загрузить бесплатно</a>
</section>
```

### Карточка

```html
<div class="print-card p-6">
  <h3 class="text-lg font-bold text-white">$9/ФОТО</h3>
  <p class="text-white/60">дешевле аренды</p>
</div>
```

---

## 12. Best Practices

- Используйте неоновые цвета для акцентов
- Применяйте тени со смещением
- Минимальные скругления углов
- Темный фон с яркими элементами
- Агрессивная типографика (uppercase, bold)

---

## 13. Чеклист

- [ ] Используются неоновые цвета
- [ ] Добавлено неоновое свечение
- [ ] Используются тени со смещением
- [ ] Минимальные скругления
- [ ] Темный фон
- [ ] Агрессивная типографика
- [ ] Hover эффекты
- [ ] Адаптивность

---

## 14. ДАШБОРД D3 - ОТДЕЛЬНАЯ ДИЗАЙН-СИСТЕМА

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
  --d3-text-muted: #62748c;       /* Неактивный текст, счётчики, метки */
  
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

**Версия:** 2.0.0 (Neon Edition) + 3.0.0 (Dashboard D3)  
**Дата:** 2024

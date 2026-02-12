# Claude Code - Инструкции для проекта VirtualStagingAI

Этот файл содержит инструкции для Claude Code по работе с проектом VirtualStagingAI.

## О проекте

VirtualStagingAI — SaaS продукт для виртуального стайлинга интерьеров с помощью AI. Проект использует Ruby on Rails 8.1.2 и SQLite3.

## Дизайн-система

### Обзор

В проекте реализована полноценная дизайн-система для обеспечения консистентности UI/UX.

**Расположение файлов:**
- `instructions/design_system.md` — полная документация на русском языке
- `aidocs/designsystem.md` — краткая документация для AI
- `app/assets/stylesheets/design_system.css` — CSS реализация
- `instructions/README.md` — руководство по использованию

### Использование дизайн-системы

При создании или изменении компонентов интерфейса:

1. **Всегда используйте CSS переменные** из дизайн-системы вместо хардкода значений
2. **Используйте готовые компоненты** (`.btn-primary`, `.card`, `.input` и т.д.)
3. **Следуйте принципам** доступности и адаптивности
4. **Проверяйте чеклист** из `aidocs/designsystem.md` перед созданием компонента

### Основные компоненты

- **Кнопки:** `.btn-primary`, `.btn-secondary`, `.btn-ghost`
- **Карточки:** `.card`, `.card-compact`, `.card-spacious`
- **Формы:** `.input`, `.textarea`
- **Badges:** `.badge-primary`, `.badge-success`, `.badge-error`, `.badge-warning`, `.badge-info`
- **Утилиты:** `.gradient-bg`, `.hero-gradient`, `.hover-scale`, `.fade-in-up`, `.container`

### Цветовая палитра

- **Primary:** `--primary-500` (#5a67d8), `--primary-600`, `--primary-700`
- **Градиенты:** `--gradient-primary`, `--gradient-hero`
- **Accent:** `--accent-gold`, `--accent-success`, `--accent-error`
- **Нейтральные:** `--gray-50` до `--gray-900`

### Типографика

- **Шрифт:** IBM Plex Sans
- **Размеры:** `--text-6xl` до `--text-xs`
- **Веса:** `--font-light` (300) до `--font-extrabold` (800)

### Spacing

Базовая единица: 4px. Используйте переменные `--space-1` до `--space-24`.

### Пример использования

```erb
<!-- Правильно: используем классы из дизайн-системы -->
<button class="btn-primary">Загрузить</button>
<div class="card">Контент</div>

<!-- Правильно: используем CSS переменные -->
<style>
  .custom-component {
    background: var(--primary-500);
    padding: var(--space-4);
    border-radius: var(--radius-lg);
  }
</style>
```

## Структура проекта

### База данных

Схема БД описана в `documentation/DB_SCHEMA.md`. Основные таблицы:
- `users` — пользователи
- `images` — изображения (input/output)
- `styles` — стили для генерации
- `generations` — генерации изображений
- `token_packages` — пакеты токенов
- `token_purchases` — покупки токенов
- `payments` — платежи

### Модели

Все модели находятся в `app/models/` с правильными ассоциациями.

### Контроллеры

- `LandingController` — лендинг страница
- Другие контроллеры будут добавлены по мере разработки

## Стиль кода

### Ruby

- Следуйте Ruby Style Guide
- Используйте RuboCop для проверки стиля
- Комментарии на русском языке для бизнес-логики

### CSS/HTML

- Используйте дизайн-систему для всех стилей
- Семантический HTML
- Accessibility first подход

## Работа с дизайн-системой

### Создание нового компонента

При создании нового компонента:

1. Проверьте, нет ли готового компонента в дизайн-системе
2. Если нет — создайте используя CSS переменные
3. Добавьте hover и focus состояния
4. Убедитесь в адаптивности
5. Проверьте accessibility

### Изменение существующих компонентов

При изменении компонентов:

1. Не нарушайте существующую функциональность
2. Используйте переменные из дизайн-системы
3. Сохраняйте консистентность с остальным интерфейсом
4. Обновляйте документацию при необходимости

## Команды для работы с дизайн-системой

### Создание дизайн-системы

Если нужно создать или обновить дизайн-систему:

```
Create design system using instructions from /instructions/design_system.md
```

Эта команда:
- Создаст/обновит дизайн-систему
- Создаст страницу с элементами (если нужно)
- Обновит `aidocs/designsystem.md`

## Документация

- **DB Schema:** `documentation/DB_SCHEMA.md`
- **Frontend Improvements:** `documentation/FRONTEND_IMPROVEMENTS.md`
- **Design System (полная):** `instructions/design_system.md`
- **Design System (краткая):** `aidocs/designsystem.md`

## Важные замечания

1. **Не используйте хардкод цветов** — всегда используйте CSS переменные
2. **Не создавайте дублирующие компоненты** — проверьте дизайн-систему сначала
3. **Следуйте принципам доступности** — все интерактивные элементы должны иметь focus состояния
4. **Адаптивность обязательна** — используйте breakpoints из дизайн-системы
5. **Консистентность важна** — используйте готовые компоненты и стили

## Обновление дизайн-системы

При обновлении дизайн-системы:

1. Обновите `instructions/design_system.md`
2. Обновите `app/assets/stylesheets/design_system.css`
3. Обновите `aidocs/designsystem.md`
4. Обновите этот файл (CLAUDE.md) при необходимости
5. Уведомите команду об изменениях

## Полезные ссылки

- [Полная документация дизайн-системы](instructions/design_system.md)
- [Краткая документация для AI](aidocs/designsystem.md)
- [Руководство по использованию](instructions/README.md)
- [Схема базы данных](documentation/DB_SCHEMA.md)

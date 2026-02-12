# Инструкции по использованию дизайн-системы

## Быстрый старт

Дизайн-система VirtualStagingAI уже подключена в `app/assets/stylesheets/application.css`.

### Использование в HTML/ERB

Просто используйте классы из дизайн-системы:

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
```

### Использование CSS переменных

Все переменные доступны через `var()`:

```css
.my-custom-component {
  background: var(--primary-500);
  padding: var(--space-4);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-md);
}
```

## Документация

Полная документация дизайн-системы находится в файле `instructions/design_system.md`.

## Компоненты

### Кнопки

- `.btn-primary` - Основная кнопка с градиентом
- `.btn-secondary` - Вторичная кнопка
- `.btn-ghost` - Прозрачная кнопка

### Карточки

- `.card` - Базовая карточка
- `.card-compact` - Компактная карточка
- `.card-spacious` - Просторная карточка

### Формы

- `.input` - Текстовое поле
- `.textarea` - Многострочное поле

### Badges

- `.badge-primary` - Основной badge
- `.badge-success` - Успех
- `.badge-error` - Ошибка
- `.badge-warning` - Предупреждение
- `.badge-info` - Информация

## Утилиты

- `.gradient-bg` - Основной градиент
- `.hero-gradient` - Градиент для hero секций
- `.hover-scale` - Эффект увеличения при hover
- `.fade-in-up` - Анимация появления снизу
- `.container` - Контейнер с максимальной шириной
- `.sticky-nav` - Липкая навигация

## Примеры

Смотрите примеры использования в `instructions/design_system.md`, раздел "Примеры использования".

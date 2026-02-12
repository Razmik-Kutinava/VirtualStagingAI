# Настройка авторизации с Devise

## Обзор

Этот документ описывает процесс настройки и реализации авторизации пользователей с помощью Devise для проекта VirtualStagingAI.

## Требования

- Ruby on Rails 8.1.2
- SQLite3
- Существующая таблица `users` с полями для Devise

## Шаги установки

### 1. Добавление Devise в Gemfile

```ruby
gem 'devise'
```

### 2. Установка и генерация

```bash
bundle install
rails generate devise:install
rails generate devise User
rails generate devise:views
```

### 3. Настройка модели User

Модель User уже существует и имеет необходимые поля из миграции. Нужно добавить Devise модули:

```ruby
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  # Существующие ассоциации
  has_many :images, dependent: :destroy
  has_many :generations, dependent: :destroy
  has_many :token_purchases, dependent: :destroy
  has_many :token_transactions, dependent: :destroy
  has_many :payments, dependent: :destroy
end
```

### 4. Настройка роутов

В `config/routes.rb` добавить:

```ruby
Rails.application.routes.draw do
  devise_for :users
  root "landing#index"
  # ... остальные роуты
end
```

### 5. Настройка контроллеров

Создать кастомные контроллеры для переопределения поведения:

- `app/controllers/users/registrations_controller.rb` - для регистрации
- `app/controllers/users/sessions_controller.rb` - для входа
- `app/controllers/users/confirmations_controller.rb` - для подтверждения email

### 6. Настройка views

Создать views в `app/views/devise/`:
- `registrations/new.html.erb` - форма регистрации
- `registrations/edit.html.erb` - редактирование профиля
- `sessions/new.html.erb` - форма входа
- `passwords/new.html.erb` - восстановление пароля
- `confirmations/new.html.erb` - повторная отправка подтверждения

### 7. Настройка mailer

Настроить отправку писем в `config/environments/development.rb`:

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.action_mailer.delivery_method = :letter_opener_web # для разработки
```

### 8. Добавление дизайна

Все auth screens должны использовать дизайн-систему из `CLAUDE.md`:
- Использовать классы `.btn-primary`, `.input`, `.card`
- Использовать CSS переменные для цветов и spacing
- Следовать принципам доступности
- Адаптивный дизайн

## Структура файлов

```
app/
├── controllers/
│   ├── users/
│   │   ├── registrations_controller.rb
│   │   ├── sessions_controller.rb
│   │   └── confirmations_controller.rb
│   └── application_controller.rb
├── views/
│   └── devise/
│       ├── registrations/
│       │   ├── new.html.erb
│       │   └── edit.html.erb
│       ├── sessions/
│       │   └── new.html.erb
│       ├── passwords/
│       │   └── new.html.erb
│       └── confirmations/
│           └── new.html.erb
└── models/
    └── user.rb
```

## Функциональность

### Регистрация

- Email и пароль (минимум 6 символов)
- Подтверждение email
- Валидация уникальности email
- Автоматический вход после регистрации (после подтверждения)

### Вход

- Email и пароль
- Опция "Запомнить меня"
- Редирект после входа

### Выход

- Кнопка выхода в навигации (для авторизованных пользователей)
- Редирект на главную после выхода

### Восстановление пароля

- Форма для ввода email
- Отправка инструкций на email
- Ссылка для сброса пароля

### Подтверждение email

- Автоматическая отправка письма при регистрации
- Ссылка для подтверждения в письме
- Возможность повторной отправки

## Интеграция с существующим кодом

### Навигация

Обновить навигацию в `app/views/landing/index.html.erb`:

```erb
<% if user_signed_in? %>
  <%= link_to "Профиль", edit_user_registration_path, class: "nav-link" %>
  <%= link_to "Выйти", destroy_user_session_path, method: :delete, class: "nav-link" %>
<% else %>
  <%= link_to "Войти", new_user_session_path, class: "nav-link" %>
  <%= link_to "Регистрация", new_user_registration_path, class: "btn-primary" %>
<% end %>
```

### Защита контроллеров

В контроллерах, требующих авторизации:

```ruby
before_action :authenticate_user!
```

## Безопасность

- Использовать HTTPS в production
- Настроить секретный ключ в credentials
- Ограничить количество попыток входа (rate limiting)
- Использовать strong parameters

## Тестирование

Создать тесты для:
- Регистрации пользователя
- Входа пользователя
- Выхода пользователя
- Восстановления пароля
- Подтверждения email

## Дополнительные настройки

### Кастомизация валидаций

В модели User можно добавить дополнительные валидации:

```ruby
validates :email, presence: true, uniqueness: true
validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
```

### Кастомизация сообщений

Создать файл `config/locales/devise.ru.yml` для русских сообщений.

## Полезные ссылки

- [Документация Devise](https://github.com/heartcombo/devise)
- [Devise Wiki](https://github.com/heartcombo/devise/wiki)
- [Дизайн-система проекта](CLAUDE.md#дизайн-система)

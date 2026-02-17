RailsAdmin.config do |config|
  # RailsAdmin 3.x поддерживает importmap для ассетов
  config.asset_source = :importmap

  # Добавляем кастомные стили через конфигурацию
  config.navigation_static_label = "VirtualStagingAI Admin"

  # Улучшаем навигацию - группируем модели
  config.navigation_static_links = {
    'Dashboard' => '/admin'
  }

  # Добавляем кастомные стили в head
  config.browser_validations = false

  # Настройка пагинации - увеличиваем количество записей на странице
  config.default_items_per_page = 100  # Больше записей на странице = меньше пагинации

  ## Аутентификация через Devise
  # Проверяем, что пользователь залогинен и является админом
  config.authenticate_with do
    # Используем warden для получения текущего пользователя
    warden = request.env['warden']
    
    # Получаем пользователя через warden
    user = warden&.user(:user) || warden&.authenticate(scope: :user)
    
    # Если пользователь не найден - редиректим на логин
    if user.nil?
      session[:return_to] = request.fullpath if request.get?
      redirect_to main_app.new_user_session_path
      next
    end
    
    # Если пользователь не админ - редиректим на главную
    unless user.admin?
      flash[:alert] = "У вас нет доступа к административной панели"
      redirect_to main_app.root_path
      next
    end
  end

  ## Текущий пользователь
  config.current_user_method(&:current_user)

  ## Авторизация - проверяем роль для каждого действия
  # КРИТИЧЕСКИ ВАЖНО: authorize_with должен возвращать boolean, а не делать redirect!
  config.authorize_with do
    user = current_user
    is_admin = user&.admin? || false
    
    # Возвращаем boolean - это критически важно для работы CRUD!
    is_admin
  end

  ## Какие модели показывать в админке
  config.included_models = ['User', 'Project', 'Folder', 'Image', 'Style',
                           'Generation', 'TokenPackage', 'TokenPurchase',
                           'Payment', 'TokenTransaction', 'AuditLog']

  ## Включаем все CRUD действия - ЯВНО для всех моделей
  # Это критически важно - без явного объявления действия могут не работать
  config.actions do
    dashboard                     # mandatory - обязательное действие
    index                         # mandatory - обязательное действие

    # Создание новых записей - доступно для всех моделей кроме AuditLog
    new do
      except ['AuditLog']         # Запретить создание логов аудита
    end

    # Экспорт данных
    export

    # Массовое удаление - доступно для всех моделей кроме AuditLog
    bulk_delete do
      except ['AuditLog']         # Запретить массовое удаление логов
    end

    # Просмотр записи - доступно для всех моделей
    show

    # Редактирование - доступно для всех моделей (AuditLog имеет read_only поля)
    edit

    # Удаление - доступно для всех моделей кроме AuditLog
    delete do
      except ['AuditLog']         # Запретить удаление логов аудита
    end

    # Просмотр в основном приложении
    show_in_app
  end

  ## Настройка отображения пользователей (скрываем чувствительные поля)
  config.model 'User' do
    navigation_label 'Пользователи'
    weight 1
    object_label_method :email
    
    # Явно включаем действие new для этой модели
    list do
      field :id
      field :email
      field :role
      field :token_balance_display do
        label 'Баланс токенов'
        pretty_value do
          user = bindings[:object]
          balance = user.token_balance || 0
          percentage = balance > 1000 ? 100 : (balance / 10.0)
          css_class = if balance > 1000
            'high'
          elsif balance > 100
            'medium'
          else
            'low'
          end
          bindings[:view].content_tag(:div, class: 'token-progress-container') do
            bindings[:view].content_tag(:div, class: 'token-progress-bar') do
              bindings[:view].content_tag(:div, balance.to_s, class: "token-progress-fill #{css_class}", style: "width: #{percentage}%;")
            end +
            bindings[:view].content_tag(:span, balance.to_s, class: 'token-progress-value')
          end
        end
      end
      field :confirmed_status do
        label 'Статус'
        pretty_value do
          user = bindings[:object]
          if user.confirmed_at
            bindings[:view].content_tag(:span, 'ПОДТВЕРЖДЕН', class: 'status-badge confirmed')
          else
            bindings[:view].content_tag(:span, 'НЕ ПОДТВЕРЖДЕН', class: 'status-badge unconfirmed')
          end
        end
      end
      field :created_at
      exclude_fields :encrypted_password, :reset_password_token,
                    :confirmation_token, :unconfirmed_email
    end

    show do
      field :id
      field :email
      field :role
      field :confirmed_at
      
      field :token_balance_info do
        label 'Баланс токенов'
        pretty_value do
          user = bindings[:object]
          balance = user.token_balance || 0
          bindings[:view].content_tag(:div, style: "padding: 15px; background: var(--panel-deep); border: 1px solid var(--border-sharp); border-radius: 4px;") do
            bindings[:view].content_tag(:div, style: "font-size: 2rem; font-weight: 700; color: var(--accent-electric); margin-bottom: 10px;") do
              balance.to_s
            end +
            bindings[:view].content_tag(:div, style: "color: var(--text-secondary); font-size: 0.9rem;") do
              "Текущий баланс токенов"
            end
          end
        end
      end
      
      field :token_transactions_list do
        label 'История транзакций'
        pretty_value do
          user = bindings[:object]
          transactions = user.token_transactions.order(created_at: :desc).limit(20)
          bindings[:view].content_tag(:div, style: "max-height: 400px; overflow-y: auto;") do
            if transactions.any?
              bindings[:view].content_tag(:table, class: "table", style: "margin: 0;") do
                bindings[:view].content_tag(:thead) do
                  bindings[:view].content_tag(:tr) do
                    bindings[:view].content_tag(:th, "Тип") +
                    bindings[:view].content_tag(:th, "Сумма") +
                    bindings[:view].content_tag(:th, "Дата")
                  end
                end +
                bindings[:view].content_tag(:tbody) do
                  transactions.map do |tx|
                    bindings[:view].content_tag(:tr) do
                      bindings[:view].content_tag(:td, tx.operation == 'spend' ? 'Расход' : 'Пополнение') +
                      bindings[:view].content_tag(:td, tx.amount.to_s, style: "color: #{tx.operation == 'spend' ? '#dc3545' : '#28a745'};") +
                      bindings[:view].content_tag(:td, tx.created_at.strftime('%d.%m.%Y %H:%M'))
                    end
                  end.join.html_safe
                end
              end
            else
              bindings[:view].content_tag(:div, "Нет транзакций", style: "color: var(--text-secondary); padding: 20px; text-align: center;")
            end
          end
        end
      end
      
      field :payments_list do
        label 'История платежей'
        pretty_value do
          user = bindings[:object]
          payments = user.payments.order(created_at: :desc).limit(20)
          bindings[:view].content_tag(:div, style: "max-height: 400px; overflow-y: auto;") do
            if payments.any?
              bindings[:view].content_tag(:table, class: "table", style: "margin: 0;") do
                bindings[:view].content_tag(:thead) do
                  bindings[:view].content_tag(:tr) do
                    bindings[:view].content_tag(:th, "Пакет") +
                    bindings[:view].content_tag(:th, "Сумма") +
                    bindings[:view].content_tag(:th, "Статус") +
                    bindings[:view].content_tag(:th, "Дата")
                  end
                end +
                bindings[:view].content_tag(:tbody) do
                  payments.map do |payment|
                    status_class = case payment.status
                    when 'succeeded' then 'status-badge succeeded'
                    when 'pending' then 'status-badge pending'
                    when 'failed' then 'status-badge failed'
                    else 'status-badge'
                    end
                    bindings[:view].content_tag(:tr) do
                      bindings[:view].content_tag(:td, payment.token_package.name) +
                      bindings[:view].content_tag(:td, "#{(payment.amount_cents || 0) / 100.0} ₽") +
                      bindings[:view].content_tag(:td, bindings[:view].content_tag(:span, payment.status.upcase, class: status_class)) +
                      bindings[:view].content_tag(:td, payment.created_at.strftime('%d.%m.%Y %H:%M'))
                    end
                  end.join.html_safe
                end
              end
            else
              bindings[:view].content_tag(:div, "Нет платежей", style: "color: var(--text-secondary); padding: 20px; text-align: center;")
            end
          end
        end
      end
      
      field :activity_stats do
        label 'Статистика активности'
        pretty_value do
          user = bindings[:object]
          bindings[:view].content_tag(:div, style: "display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;") do
            bindings[:view].content_tag(:div, style: "padding: 15px; background: var(--panel-deep); border: 1px solid var(--border-sharp); border-radius: 4px; text-align: center;") do
              bindings[:view].content_tag(:div, user.projects.count, style: "font-size: 1.5rem; font-weight: 700; color: var(--accent-electric);") +
              bindings[:view].content_tag(:div, "Проектов", style: "color: var(--text-secondary); font-size: 0.9rem; margin-top: 5px;")
            end +
            bindings[:view].content_tag(:div, style: "padding: 15px; background: var(--panel-deep); border: 1px solid var(--border-sharp); border-radius: 4px; text-align: center;") do
              bindings[:view].content_tag(:div, user.generations.count, style: "font-size: 1.5rem; font-weight: 700; color: var(--accent-blue);") +
              bindings[:view].content_tag(:div, "Генераций", style: "color: var(--text-secondary); font-size: 0.9rem; margin-top: 5px;")
            end +
            bindings[:view].content_tag(:div, style: "padding: 15px; background: var(--panel-deep); border: 1px solid var(--border-sharp); border-radius: 4px; text-align: center;") do
              bindings[:view].content_tag(:div, user.images.count, style: "font-size: 1.5rem; font-weight: 700; color: #ffc107;") +
              bindings[:view].content_tag(:div, "Изображений", style: "color: var(--text-secondary); font-size: 0.9rem; margin-top: 5px;")
            end
          end
        end
      end
      
      field :projects
      field :images
      field :generations
      field :token_purchases
      field :created_at
      field :updated_at
    end

    edit do
      field :email
      field :role
      field :password do
        help false  # Отключаем автоматическую помощь, которая вызывает ошибку
        required false  # Пароль не обязателен при редактировании
      end
      field :password_confirmation do
        help false  # Отключаем автоматическую помощь, которая вызывает ошибку
        required false  # Пароль не обязателен при редактировании
      end
    end
    
    # Переопределяем метод update для RailsAdmin, чтобы пропустить валидацию пароля
    # Это делается через кастомный контроллер RailsAdmin

    create do
      field :email
      field :role
      field :password do
        help false  # Отключаем автоматическую помощь, которая вызывает ошибку
      end
      field :password_confirmation do
        help false  # Отключаем автоматическую помощь, которая вызывает ошибку
      end
    end
  end

  ## Настройка отображения AuditLog
  config.model 'AuditLog' do
    navigation_label 'Аудит'
    weight 7
    
    configure :user do
      filterable true
    end
    
    configure :action do
      filterable true
    end
    
    configure :ip_address do
      filterable true
      searchable true
    end
    
    configure :created_at do
      filterable true
    end

    list do
      field :id
      field :user
      field :action
      field :details
      field :ip_address
      field :created_at
    end

    show do
      field :id
      field :user
      field :action
      field :details
      field :ip_address
      field :created_at
      field :updated_at
    end
  end

  # Группировка моделей в навигации (User уже настроен выше)

  ## Настройка Project
  config.model 'Project' do
    navigation_label 'Проекты'
    weight 2
    object_label_method :name

    list do
      field :id
      field :name
      field :user
      field :status
      field :created_at
    end

    show do
      field :id
      field :name
      field :description
      field :user
      field :property_address
      field :property_type
      field :status
      field :thumbnail_url
      field :folders
      field :images
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :description
      field :user
      field :property_address
      field :property_type
      field :status
      field :thumbnail_url
    end

    create do
      field :name
      field :description
      field :user
      field :property_address
      field :property_type
      field :status
      field :thumbnail_url
    end
  end

  ## Настройка Folder
  config.model 'Folder' do
    navigation_label 'Проекты'
    weight 2

    list do
      field :id
      field :name
      field :project
      field :icon
      field :sort_order
      field :created_at
    end

    show do
      field :id
      field :name
      field :icon
      field :project
      field :sort_order
      field :images
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :icon
      field :project
      field :sort_order
    end

    create do
      field :name
      field :icon
      field :project
      field :sort_order
    end
  end

  ## Настройка Image
  config.model 'Image' do
    navigation_label 'Изображения'
    weight 3

    list do
      field :id
      field :thumbnail do
        label 'Миниатюра'
        pretty_value do
          if bindings[:object].file.attached?
            bindings[:view].tag(:img, 
              src: bindings[:view].rails_blob_path(bindings[:object].file.variant(resize_to_limit: [100, 100]), only_path: true),
              style: "max-width: 100px; max-height: 100px; border-radius: 4px; cursor: pointer;",
              class: "image-thumbnail",
              data: { 
                image_id: bindings[:object].id,
                full_url: bindings[:view].rails_blob_path(bindings[:object].file, only_path: true)
              }
            )
          else
            "Нет изображения"
          end
        end
      end
      field :user
      field :project
      field :folder
      field :kind
      field :created_at
    end

    show do
      field :id
      field :user
      field :project
      field :folder
      field :kind
      field :file do
        pretty_value do
          if value.attached?
            bindings[:view].tag(:img, src: bindings[:view].url_for(value), style: "max-width: 300px; height: auto;")
          else
            "Файл не загружен"
          end
        end
      end
      field :metadata
      field :deleted_at
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :project
      field :folder
      field :kind
      field :file
      field :metadata do
        formatted_value do
          value.is_a?(Hash) ? JSON.pretty_generate(value) : value.to_s
        end
      end
      field :deleted_at
    end

    create do
      field :user
      field :project
      field :folder
      field :kind
      field :file
      field :metadata
    end
  end

  ## Настройка Style
  config.model 'Style' do
    navigation_label 'Стили'
    weight 4

    list do
      field :id
      field :name
      field :created_at
    end

    show do
      field :id
      field :name
      field :prompt
      field :generations
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :prompt
    end

    create do
      field :name
      field :prompt
    end
  end

  ## Настройка Generation
  config.model 'Generation' do
    navigation_label 'Генерации'
    weight 5
    
    configure :status do
      filterable true
    end
    
    configure :user do
      filterable true
    end
    
    configure :style do
      filterable true
    end

    list do
      field :id
      field :user
      field :input_image
      field :style
      field :status do
        pretty_value do
          status = bindings[:object].status
          css_class = case status
          when 'queued' then 'status-badge queued'
          when 'running' then 'status-badge running'
          when 'succeeded' then 'status-badge succeeded'
          when 'failed' then 'status-badge failed'
          else 'status-badge'
          end
          bindings[:view].content_tag(:span, status.upcase, class: css_class)
        end
      end
      field :tokens_spent
      field :created_at
    end

    show do
      field :id
      field :user
      field :input_image
      field :output_image
      field :style
      field :status do
        pretty_value do
          status = bindings[:object].status
          css_class = case status
          when 'queued' then 'status-badge queued'
          when 'running' then 'status-badge running'
          when 'succeeded' then 'status-badge succeeded'
          when 'failed' then 'status-badge failed'
          else 'status-badge'
          end
          bindings[:view].content_tag(:span, status.upcase, class: css_class)
        end
      end
      field :tokens_spent
      field :error
      field :favorites
      field :token_transactions
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :input_image
      field :output_image
      field :style
      field :status
      field :tokens_spent
      field :error
    end

    create do
      field :user
      field :input_image
      field :output_image
      field :style
      field :status
      field :tokens_spent
      field :error
    end
  end

  ## Настройка TokenPackage
  config.model 'TokenPackage' do
    navigation_label 'Тарифы и платежи'
    weight 6

    list do
      field :id
      field :name
      field :tokens_amount
      field :price_cents
      field :active
      field :created_at
    end

    show do
      field :id
      field :name
      field :description
      field :tokens_amount
      field :price_cents do
        formatted_value do
          "#{value / 100.0} руб." if value
        end
      end
      field :validity_days
      field :active
      field :token_purchases
      field :payments
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :description
      field :tokens_amount
      field :price_cents
      field :validity_days
      field :active
    end

    create do
      field :name
      field :description
      field :tokens_amount
      field :price_cents
      field :validity_days
      field :active
    end
  end

  ## Настройка TokenPurchase
  config.model 'TokenPurchase' do
    navigation_label 'Тарифы и платежи'
    weight 6

    list do
      field :id
      field :user
      field :token_package
      field :tokens_remaining
      field :purchased_at
      field :expires_at
    end

    show do
      field :id
      field :user
      field :token_package
      field :tokens_remaining
      field :purchased_at
      field :expires_at
      field :token_transactions
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :token_package
      field :tokens_remaining
      field :purchased_at
      field :expires_at
    end

    create do
      field :user
      field :token_package
      field :tokens_remaining
      field :purchased_at
      field :expires_at
    end
  end

  ## Настройка Payment
  config.model 'Payment' do
    navigation_label 'Тарифы и платежи'
    weight 6
    
    configure :status do
      filterable true
    end
    
    configure :user do
      filterable true
    end
    
    configure :token_package do
      filterable true
    end
    
    configure :cloudpayments_transaction_id do
      searchable true
    end
    
    configure :amount_cents do
      filterable true
    end
    
    configure :created_at do
      filterable true
    end

    list do
      field :id
      field :user
      field :token_package
      field :status do
        pretty_value do
          status = bindings[:object].status
          css_class = case status
          when 'pending' then 'status-badge pending'
          when 'succeeded' then 'status-badge succeeded'
          when 'failed' then 'status-badge failed'
          else 'status-badge'
          end
          bindings[:view].content_tag(:span, status.upcase, class: css_class)
        end
      end
      field :amount_cents do
        formatted_value do
          "#{(value || 0) / 100.0} ₽" if value
        end
      end
      field :paid_at
      field :created_at
    end

    show do
      field :id
      field :user
      field :token_package
      field :status
      field :amount_cents do
        formatted_value do
          "#{value / 100.0} #{bindings[:object].currency}" if value
        end
      end
      field :currency
      field :card_last_four
      field :card_type
      field :cloudpayments_transaction_id
      field :cloudpayments_invoice_id
      field :paid_at
      field :metadata
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :token_package
      field :status
      field :amount_cents
      field :currency
      field :card_last_four
      field :card_type
      field :cloudpayments_transaction_id
      field :cloudpayments_invoice_id
      field :paid_at
      field :metadata do
        formatted_value do
          value.is_a?(Hash) ? JSON.pretty_generate(value) : value.to_s
        end
      end
    end

    create do
      field :user
      field :token_package
      field :status
      field :amount_cents
      field :currency
      field :card_last_four
      field :card_type
      field :cloudpayments_transaction_id
      field :cloudpayments_invoice_id
      field :paid_at
      field :metadata
    end
  end

  ## Настройка TokenTransaction
  config.model 'TokenTransaction' do
    navigation_label 'Тарифы и платежи'
    weight 6

    list do
      field :id
      field :user
      field :operation
      field :amount
      field :created_at
    end

    show do
      field :id
      field :user
      field :token_purchase
      field :generation
      field :operation
      field :amount
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :token_purchase
      field :generation
      field :operation
      field :amount
    end

    create do
      field :user
      field :token_purchase
      field :generation
      field :operation
      field :amount
    end
  end

end
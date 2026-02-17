class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # Роли пользователей
  enum :role, { user: 0, admin: 1, super_admin: 2 }

  has_many :projects, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :generations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :token_purchases, dependent: :destroy
  has_many :token_transactions, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :audit_logs, dependent: :nullify

  # Проверка, является ли пользователь администратором (любым)
  # Rails enum автоматически создает методы admin? и super_admin? для проверки конкретной роли
  # Но они проверяют ТОЧНОЕ соответствие. Нам нужен метод который проверяет оба типа админов
  # Переименуем наш метод чтобы избежать конфликта с автоматически генерируемым методом admin?
  alias_method :is_admin?, :admin?

  # Переопределяем admin? чтобы проверять обе роли админа корректно
  def admin?
    # Используем методы генерируемые enum (они возвращают true/false)
    super || super_admin?
  end

  # Колбэк для обработки обновления через RailsAdmin
  # Удаляем пустые пароли перед валидацией
  before_validation :remove_blank_passwords, on: :update
  
  def remove_blank_passwords
    # Если пароль не указан при обновлении, удаляем его из атрибутов
    if password.blank? && password_confirmation.blank?
      self.password = nil
      self.password_confirmation = nil
      # Пропускаем валидацию пароля для этого обновления
      @skip_password_validation = true
    end
  end
  
  # Переопределяем валидацию пароля для RailsAdmin
  # Пароль не обязателен при обновлении через админку, если он не указан
  def password_required?
    # Если установлен флаг пропуска валидации - пароль не обязателен
    return false if @skip_password_validation
    
    # Если это новый запись - пароль обязателен
    return true if new_record?
    
    # Если пароль указан - он должен быть валидным
    return true if password.present? || password_confirmation.present?
    
    # Если пароль не указан и это обновление - пароль не обязателен
    false
  end

  # Подсчет баланса токенов
  def token_balance
    # Бессрочные покупки (expires_at = NULL) и активные покупки (expires_at > текущее время)
    active_purchases = token_purchases.where("expires_at IS NULL OR expires_at > ?", Time.current)
    total_purchased = active_purchases.sum(:tokens_remaining) || 0
    total_spent = token_transactions.where(operation: "spend").sum(:amount) || 0
    total_purchased - total_spent
  end
end

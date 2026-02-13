class UpdateGenerationsStatusEnum < ActiveRecord::Migration[8.1]
  def up
    # В SQLite нет поддержки enum, поэтому просто обновляем возможные значения
    # В PostgreSQL можно было бы использовать ALTER TYPE, но для совместимости
    # оставляем как строку и обновляем в модели
    # Никаких изменений в БД не требуется, enum обрабатывается в модели Generation
    # Статус 'cancelled' уже добавлен в модель Generation
  end

  def down
    # Откат не требуется, так как мы не меняем структуру БД
  end
end

class RemoveSubscriptionsTables < ActiveRecord::Migration[8.1]
  def up
    # Удаляем таблицы subscriptions и subscription_plans, если они существуют
    drop_table :subscriptions if table_exists?(:subscriptions)
    drop_table :subscription_plans if table_exists?(:subscription_plans)
  end

  def down
    # При откате не восстанавливаем, так как эти таблицы не нужны
    # Если потребуется восстановление, нужно будет создать миграцию отдельно
  end
end

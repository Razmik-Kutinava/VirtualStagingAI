class CreateFolders < ActiveRecord::Migration[8.1]
  def change
    create_table :folders do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name, null: false
      t.string :icon
      t.integer :sort_order, default: 0

      t.timestamps
    end
    # Индекс уже создается автоматически через t.references
  end
end

class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :property_address
      t.string :property_type
      t.string :status, default: 'active'
      t.text :thumbnail_url

      t.timestamps
    end
    # Индекс уже создается автоматически через t.references
  end
end

class CreateImages < ActiveRecord::Migration[8.1]
  def change
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true
      t.string :kind, null: false
      t.string :room_type
      t.json :metadata

      t.timestamps
    end
  end
end

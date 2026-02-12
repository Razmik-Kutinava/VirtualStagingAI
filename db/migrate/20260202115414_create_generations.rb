class CreateGenerations < ActiveRecord::Migration[8.1]
  def change
    create_table :generations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :input_image, null: false, foreign_key: { to_table: :images }
      t.references :output_image, null: true, foreign_key: { to_table: :images }
      t.references :style, null: false, foreign_key: true
      t.string :status, default: "queued"
      t.text :error

      t.timestamps
    end
  end
end

class AddDeletedAtToImages < ActiveRecord::Migration[8.1]
  def change
    add_column :images, :deleted_at, :datetime
  end
end

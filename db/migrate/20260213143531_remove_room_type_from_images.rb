class RemoveRoomTypeFromImages < ActiveRecord::Migration[8.1]
  def change
    remove_column :images, :room_type, :string
  end
end

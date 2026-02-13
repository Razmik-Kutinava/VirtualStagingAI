class AddProjectAndFolderToImages < ActiveRecord::Migration[8.1]
  def change
    add_reference :images, :project, null: true, foreign_key: true, index: true
    add_reference :images, :folder, null: true, foreign_key: true, index: true
    # Индексы создаются автоматически через add_reference с index: true
  end
end

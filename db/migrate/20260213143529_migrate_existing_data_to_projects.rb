class MigrateExistingDataToProjects < ActiveRecord::Migration[8.1]
  def up
    # Используем raw SQL для избежания проблем с моделями во время миграции
    execute <<-SQL
      -- Создаем дефолтный проект для каждого пользователя с изображениями
      INSERT INTO projects (user_id, name, description, status, created_at, updated_at)
      SELECT DISTINCT 
        i.user_id,
        'Мой первый проект',
        'Автоматически созданный проект из существующих изображений',
        'active',
        MIN(i.created_at),
        CURRENT_TIMESTAMP
      FROM images i
      WHERE i.kind = 'input' AND i.deleted_at IS NULL
      GROUP BY i.user_id;
    SQL

    # Создаем дефолтную папку "Все фото" для каждого проекта
    execute <<-SQL
      INSERT INTO folders (project_id, name, icon, sort_order, created_at, updated_at)
      SELECT 
        p.id,
        'Все фото',
        '⬜',
        0,
        p.created_at,
        CURRENT_TIMESTAMP
      FROM projects p;
    SQL

    # Перемещаем все изображения в соответствующие проекты и папки
    # SQLite не поддерживает алиасы в UPDATE, поэтому используем подзапросы
    execute <<-SQL
      UPDATE images
      SET project_id = (
        SELECT p.id 
        FROM projects p 
        WHERE p.user_id = images.user_id 
        LIMIT 1
      ),
      folder_id = (
        SELECT f.id 
        FROM folders f 
        INNER JOIN projects p ON f.project_id = p.id 
        WHERE p.user_id = images.user_id 
        AND f.name = 'Все фото'
        LIMIT 1
      )
      WHERE kind = 'input' AND deleted_at IS NULL;
    SQL

      # Если room_type еще существует, создаем дополнительные папки
    if column_exists?(:images, :room_type)
      # Используем Ruby код для лучшей совместимости с SQLite
      room_type_mapping = {
        'living_room' => { name: 'Гостиная', icon: '🛋️' },
        'bedroom' => { name: 'Спальня', icon: '🛏️' },
        'dining_room' => { name: 'Столовая', icon: '🍽️' },
        'kitchen' => { name: 'Кухня', icon: '🍳' },
        'bathroom' => { name: 'Ванная', icon: '🚿' },
        'office' => { name: 'Офис', icon: '💼' },
        'main_area' => { name: 'Главная зона', icon: '🏠' }
      }

      # Для каждого проекта создаем папки на основе room_type
      Project.reset_column_information
      Folder.reset_column_information
      Image.reset_column_information

      Project.find_each do |project|
        room_types = Image.where(user_id: project.user_id, kind: 'input')
          .where.not(room_type: [nil, ''])
          .where(deleted_at: nil)
          .distinct
          .pluck(:room_type)

        room_types.each_with_index do |room_type, index|
          mapping = room_type_mapping[room_type] || { name: 'Другое', icon: '🖼️' }
          
          folder = Folder.create!(
            project_id: project.id,
            name: mapping[:name],
            icon: mapping[:icon],
            sort_order: index + 1
          )

          Image.where(
            user_id: project.user_id,
            kind: 'input',
            room_type: room_type,
            deleted_at: nil
          ).update_all(folder_id: folder.id)
        end
      end
    end
  end

  def down
    # При откате удаляем все проекты и возвращаем project_id в NULL
    execute "UPDATE images SET project_id = NULL, folder_id = NULL"
    execute "DELETE FROM folders"
    execute "DELETE FROM projects"
  end
end


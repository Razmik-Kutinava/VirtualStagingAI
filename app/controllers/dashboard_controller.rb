class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @folder = params[:folder] || "all"
    @images = current_user.images.input.includes(:input_generations, :folder, :project)
    
    # Фильтрация по папке
    case @folder
    when "all"
      @images = @images.not_deleted
    when "unfiled"
      # Изображения без папки (folder_id = nil)
      @images = @images.not_deleted.where(folder_id: nil)
    when "trash"
      @images = @images.deleted
    when "living_room", "bedroom", "dining_room", "kitchen", "bathroom", "office", "main_area"
      # Фильтрация по категории комнаты
      # Ищем папки с соответствующими названиями во всех проектах пользователя
      room_names = {
        "living_room" => ["Гостиная", "Living Room"],
        "bedroom" => ["Спальня", "Bedroom"],
        "dining_room" => ["Столовая", "Dining Room"],
        "kitchen" => ["Кухня", "Kitchen"],
        "bathroom" => ["Ванная", "Bathroom"],
        "office" => ["Офис", "Office"],
        "main_area" => ["Главная зона", "Main Area"]
      }
      
      folder_names = room_names[@folder] || []
      # Ищем папки по точному совпадению названия
      folders = Folder.joins(:project)
                     .where(projects: { user_id: current_user.id })
                     .where("folders.name IN (?)", folder_names)
      
      if folders.any?
        folder_ids = folders.pluck(:id)
        Rails.logger.debug "Found #{folders.count} folders for category #{@folder}: #{folder_ids.inspect}"
        @images = @images.not_deleted.where(folder_id: folder_ids)
        Rails.logger.debug "Filtered images count: #{@images.count}"
      else
        # Если папок нет, показываем все
        Rails.logger.debug "No folders found for category #{@folder}"
        @images = @images.not_deleted
      end
    else
      # Фильтрация по folder_id (slug теперь соответствует id папки)
      # Ищем папку среди всех проектов пользователя
      folder_id = @folder.to_i
      if folder_id > 0
        folder = Folder.joins(:project)
                      .where(id: folder_id, projects: { user_id: current_user.id })
                      .first
        if folder
          @images = @images.not_deleted.where(folder_id: folder.id)
        else
          # Если папка не найдена, показываем все
          @images = @images.not_deleted
        end
      else
        @images = @images.not_deleted
      end
    end
    
    # Пагинация (используем простую пагинацию через offset/limit)
    @page = params[:page].to_i
    @page = 1 if @page < 1
    @per_page = 12
    @total_pages = (@images.count.to_f / @per_page).ceil
    @images = @images.order(created_at: :desc).offset((@page - 1) * @per_page).limit(@per_page)
    
    # Статистика для sidebar
    @total_photos = current_user.images.input.not_deleted.count
    # "Без папки" - только те изображения, у которых folder_id явно равен nil (не в папке проекта)
    @unfiled_count = current_user.images.input.not_deleted.where(folder_id: nil).count
    @trash_count = current_user.images.input.deleted.count
    
    # Получаем проекты пользователя с папками
    @projects = current_user.projects.active.includes(:folders).order(created_at: :desc)
    
    # Статические категории комнат (как было изначально)
    @room_categories = [
      { name: "Гостиная", slug: "living_room", icon: "🛋️" },
      { name: "Спальня", slug: "bedroom", icon: "🛏️" },
      { name: "Столовая", slug: "dining_room", icon: "🍽️" },
      { name: "Кухня", slug: "kitchen", icon: "🍳" },
      { name: "Ванная", slug: "bathroom", icon: "🚿" },
      { name: "Офис", slug: "office", icon: "💼" },
      { name: "Главная зона", slug: "main_area", icon: "🏠" }
    ]
    
    # Подсчитываем количество фото в каждой категории комнат
    # Ищем папки с соответствующими названиями во всех проектах пользователя
    @room_categories.each do |category|
      # Ищем папки с таким названием во всех проектах пользователя
      # Используем точное совпадение названия
      folders = Folder.joins(:project)
                     .where(projects: { user_id: current_user.id })
                     .where("folders.name = ?", category[:name])
      
      folder_ids = folders.pluck(:id)
      Rails.logger.debug "Category #{category[:name]}: Found #{folders.count} folders with IDs: #{folder_ids.inspect}"
      
      category[:count] = if folder_ids.any?
        count = current_user.images.input.not_deleted
                    .where(folder_id: folder_ids)
                    .count
        Rails.logger.debug "Category #{category[:name]}: Found #{count} images"
        count
      else
        Rails.logger.debug "Category #{category[:name]}: No folders found"
        0
      end
    end
    
    # Список папок с количеством фото из проектов пользователя
    @folders = []
    @projects.each do |project|
      project.folders.ordered.each do |folder|
        count = current_user.images.input.not_deleted.where(folder_id: folder.id).count
        @folders << {
          name: folder.name,
          slug: folder.id.to_s,
          icon: folder.icon || "📁",
          count: count,
          project_id: project.id
        }
      end
    end
    
    # Баланс токенов
    @token_balance = current_user.token_balance
    
    # Проверка, есть ли у пользователя успешные платежи
    @has_paid = current_user.payments.where(status: 'succeeded').exists?
  end
end

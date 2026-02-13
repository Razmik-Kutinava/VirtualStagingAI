class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show], if: -> { params[:project_id].present? && params[:id].present? }
  before_action :set_project, only: [:destroy]

  # Index action - редирект на дашборд
  def index
    redirect_to dashboard_path
  end

  # Действие для создания нового проекта (модальное окно)
  def new_project
    @project = current_user.projects.build
    respond_to do |format|
      format.html { render partial: 'projects/new_project_modal' }
      format.json { render json: { html: render_to_string(partial: 'projects/new_project_modal') } }
    end
  end

  # Создание проекта
  def create_project
    @project = current_user.projects.build(project_params)
    
    if @project.save
      # Создаем дефолтные папки для проекта
      create_default_folders(@project)
      
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Проект '#{@project.name}' успешно создан" }
        format.json { render json: { success: true, redirect_url: dashboard_path } }
      end
    else
      respond_to do |format|
        format.html { render partial: 'projects/new_project_modal', status: :unprocessable_entity }
        format.json { render json: { success: false, errors: @project.errors.full_messages } }
      end
    end
  end

  def new
    # Убеждаемся, что у пользователя есть хотя бы один проект
    if current_user.projects.active.empty?
      # Создаем дефолтный проект
      project = current_user.projects.create!(
        name: "Мой первый проект",
        description: "Проект по умолчанию",
        status: 'active'
      )
      # Создаем дефолтные папки для всех категорий комнат
      room_categories = [
        { name: "Гостиная", icon: "🛋️", sort_order: 1 },
        { name: "Спальня", icon: "🛏️", sort_order: 2 },
        { name: "Столовая", icon: "🍽️", sort_order: 3 },
        { name: "Кухня", icon: "🍳", sort_order: 4 },
        { name: "Ванная", icon: "🚿", sort_order: 5 },
        { name: "Офис", icon: "💼", sort_order: 6 },
        { name: "Главная зона", icon: "🏠", sort_order: 7 }
      ]
      
      room_categories.each do |category|
        project.folders.create!(
          name: category[:name],
          icon: category[:icon],
          sort_order: category[:sort_order]
        )
      end
      
      # Также создаем папку "Все фото"
      project.folders.create!(
        name: "Все фото",
        icon: "⬜",
        sort_order: 0
      )
    end
    @image = current_user.images.build(kind: :input)
    @projects = current_user.projects.active.includes(:folders)
    @room_categories = [
      { name: "Гостиная", slug: "living_room", icon: "🛋️" },
      { name: "Спальня", slug: "bedroom", icon: "🛏️" },
      { name: "Столовая", slug: "dining_room", icon: "🍽️" },
      { name: "Кухня", slug: "kitchen", icon: "🍳" },
      { name: "Ванная", slug: "bathroom", icon: "🚿" },
      { name: "Офис", slug: "office", icon: "💼" },
      { name: "Главная зона", slug: "main_area", icon: "🏠" }
    ]
  end

  def create
    # Получаем параметры и конвертируем в числа
    Rails.logger.debug "=== Image Upload Debug ==="
    Rails.logger.debug "Raw params: #{params.inspect}"
    Rails.logger.debug "Image params: #{image_params.inspect}"
    
    image_params_hash = image_params.to_h
    project_id = image_params_hash[:project_id].presence&.to_i
    folder_id = image_params_hash[:folder_id].presence&.to_i
    file_present = image_params_hash[:file].present?
    
    Rails.logger.debug "Project ID: #{project_id} (#{project_id.class}), Folder ID: #{folder_id} (#{folder_id.class})"
    Rails.logger.debug "File present: #{file_present}"
    
    # Если указана папка, но не указан проект - устанавливаем проект из папки
    if folder_id.present? && project_id.blank?
      folder = Folder.joins(:project).where(id: folder_id, projects: { user_id: current_user.id }).first
      if folder
        project_id = folder.project_id
        Rails.logger.debug "Set project_id from folder: #{project_id}"
      else
        Rails.logger.debug "Folder #{folder_id} not found or doesn't belong to user"
      end
    end
    
    # Валидация: если указана папка и проект, проверяем что папка принадлежит проекту
    if folder_id.present? && project_id.present?
      # Проверяем что проект принадлежит пользователю
      project = current_user.projects.find_by(id: project_id)
      unless project
        Rails.logger.debug "Project #{project_id} not found or doesn't belong to user"
        @projects = current_user.projects.active.includes(:folders)
        @room_categories = [
          { name: "Гостиная", slug: "living_room", icon: "🛋️" },
          { name: "Спальня", slug: "bedroom", icon: "🛏️" },
          { name: "Столовая", slug: "dining_room", icon: "🍽️" },
          { name: "Кухня", slug: "kitchen", icon: "🍳" },
          { name: "Ванная", slug: "bathroom", icon: "🚿" },
          { name: "Офис", slug: "office", icon: "💼" },
          { name: "Главная зона", slug: "main_area", icon: "🏠" }
        ]
        @image = current_user.images.build(image_params.merge(kind: :input))
        @image.errors.add(:project_id, "не найден")
        render :new, status: :unprocessable_entity
        return
      end
      
      # Проверяем что папка принадлежит проекту
      # Используем более мягкую проверку - ищем папку среди всех папок пользователя, но проверяем принадлежность к проекту
      folder = Folder.joins(:project)
                     .where(id: folder_id, project_id: project_id, projects: { user_id: current_user.id })
                     .first
      
      unless folder
        Rails.logger.debug "Validation failed: Folder #{folder_id} does not belong to project #{project_id}"
        Rails.logger.debug "Available folders for project #{project_id}:"
        project.folders.each do |f|
          Rails.logger.debug "  - Folder ID: #{f.id}, Name: #{f.name}"
        end
        Rails.logger.debug "Requested folder_id: #{folder_id}, project_id: #{project_id}"
        
        # Если папка не найдена, но она существует у пользователя - возможно она из другого проекта
        # В этом случае просто игнорируем folder_id и сохраняем только с project_id
        existing_folder = Folder.joins(:project).where(id: folder_id, projects: { user_id: current_user.id }).first
        if existing_folder
          Rails.logger.debug "Folder #{folder_id} exists but belongs to project #{existing_folder.project_id}, not #{project_id}"
          Rails.logger.debug "Ignoring folder_id and saving with project_id only"
          folder_id = nil
        else
          @projects = current_user.projects.active.includes(:folders)
          @room_categories = [
            { name: "Гостиная", slug: "living_room", icon: "🛋️" },
            { name: "Спальня", slug: "bedroom", icon: "🛏️" },
            { name: "Столовая", slug: "dining_room", icon: "🍽️" },
            { name: "Кухня", slug: "kitchen", icon: "🍳" },
            { name: "Ванная", slug: "bathroom", icon: "🚿" },
            { name: "Офис", slug: "office", icon: "💼" },
            { name: "Главная зона", slug: "main_area", icon: "🏠" }
          ]
          @image = current_user.images.build(image_params.merge(kind: :input))
          @image.errors.add(:folder_id, "не принадлежит выбранному проекту")
          render :new, status: :unprocessable_entity
          return
        end
      else
        Rails.logger.debug "Validation passed: Folder #{folder_id} belongs to project #{project_id}"
      end
    end
    
    # Создаем изображение с правильными параметрами
    # Удаляем project_id и folder_id из image_params, чтобы установить их правильно
    clean_params = image_params.except(:project_id, :folder_id)
    
    # Создаем хеш атрибутов для изображения
    image_attributes = {
      kind: :input
    }
    
    # Добавляем файл из clean_params
    image_attributes[:file] = clean_params[:file] if clean_params[:file].present?
    
    # Устанавливаем project_id и folder_id из проверенных значений (как целые числа)
    image_attributes[:project_id] = project_id if project_id.present?
    image_attributes[:folder_id] = folder_id if folder_id.present?
    
    Rails.logger.debug "Final image_attributes: project_id=#{image_attributes[:project_id]}, folder_id=#{image_attributes[:folder_id]}"
    
    @image = current_user.images.build(image_attributes)
    
    Rails.logger.debug "Image project_id before save: #{@image.project_id}"
    Rails.logger.debug "Image folder_id before save: #{@image.folder_id}"
    
    if @image.save
      # Перезагружаем изображение для получения актуальных данных
      @image.reload
      
      Rails.logger.debug "Image saved successfully!"
      Rails.logger.debug "Image ID: #{@image.id}"
      Rails.logger.debug "Image project_id after save: #{@image.project_id}"
      Rails.logger.debug "Image folder_id after save: #{@image.folder_id}"
      
      # Редирект на дашборд в нужную папку, если указана
      if @image.folder_id.present?
        redirect_to dashboard_path(folder: @image.folder_id.to_s), notice: "✅ Фото успешно загружено в папку '#{@image.folder.name}'!"
      elsif @image.project_id.present?
        # Если папка не указана, но проект есть - редирект на дашборд
        redirect_to dashboard_path, notice: "✅ Фото успешно загружено в проект '#{@image.project.name}'!"
      else
        # Иначе на дашборд
        redirect_to dashboard_path, notice: "✅ Фото успешно загружено!"
      end
    else
      Rails.logger.debug "Image save failed: #{@image.errors.full_messages}"
      @projects = current_user.projects.active.includes(:folders)
      @room_categories = [
        { name: "Гостиная", slug: "living_room", icon: "🛋️" },
        { name: "Спальня", slug: "bedroom", icon: "🛏️" },
        { name: "Столовая", slug: "dining_room", icon: "🍽️" },
        { name: "Кухня", slug: "kitchen", icon: "🍳" },
        { name: "Ванная", slug: "bathroom", icon: "🚿" },
        { name: "Офис", slug: "office", icon: "💼" },
        { name: "Главная зона", slug: "main_area", icon: "🏠" }
      ]
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Если передан project_id и id - это запрос на изображение внутри проекта
    if params[:project_id].present? && params[:id].present?
      @image = current_user.images.find_by(id: params[:id], project_id: params[:project_id])
      unless @image
        redirect_to dashboard_path, alert: "Изображение не найдено"
        return
      end
      @generations = @image.input_generations.includes(:style, :output_image).order(created_at: :desc)
    else
      # Если передан только id без project_id - это запрос на проект (старый формат)
      # Перенаправляем на дашборд
      redirect_to dashboard_path
    end
  end

  # Удаление проекта
  def destroy
    project_name = @project.name
    
    if @project.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Проект '#{project_name}' успешно удален" }
        format.json { render json: { success: true, message: "Проект '#{project_name}' успешно удален" } }
      end
    else
      respond_to do |format|
        format.html { redirect_to dashboard_path, alert: "Не удалось удалить проект '#{project_name}'" }
        format.json { render json: { success: false, errors: @project.errors.full_messages } }
      end
    end
  end

  private

  def set_image
    if params[:project_id].present? && params[:id].present?
      @image = current_user.images.find_by(id: params[:id], project_id: params[:project_id])
      unless @image
        redirect_to dashboard_path, alert: "Изображение не найдено"
        return
      end
    else
      @image = current_user.images.find(params[:id])
    end
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:file, :project_id, :folder_id)
  end

  def project_params
    params.require(:project).permit(:name, :description, :property_address, :property_type)
  end

  def create_default_folders(project)
    room_categories = [
      { name: "Гостиная", icon: "🛋️", sort_order: 1 },
      { name: "Спальня", icon: "🛏️", sort_order: 2 },
      { name: "Столовая", icon: "🍽️", sort_order: 3 },
      { name: "Кухня", icon: "🍳", sort_order: 4 },
      { name: "Ванная", icon: "🚿", sort_order: 5 },
      { name: "Офис", icon: "💼", sort_order: 6 },
      { name: "Главная зона", icon: "🏠", sort_order: 7 }
    ]
    
    room_categories.each do |category|
      project.folders.create!(
        name: category[:name],
        icon: category[:icon],
        sort_order: category[:sort_order]
      )
    end
    
    # Также создаем папку "Все фото"
    project.folders.create!(
      name: "Все фото",
      icon: "⬜",
      sort_order: 0
    )
  end
end

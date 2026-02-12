class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @folder = params[:folder] || "all"
    @images = current_user.images.input.includes(:input_generations)
    
    # Фильтрация по папке
    case @folder
    when "all"
      @images = @images.not_deleted
    when "unfiled"
      @images = @images.not_deleted.where(room_type: [nil, ""])
    when "trash"
      @images = @images.deleted
    else
      @images = @images.not_deleted.where(room_type: @folder)
    end
    
    # Пагинация (используем простую пагинацию через offset/limit)
    @page = params[:page].to_i
    @page = 1 if @page < 1
    @per_page = 12
    @total_pages = (@images.count.to_f / @per_page).ceil
    @images = @images.order(created_at: :desc).offset((@page - 1) * @per_page).limit(@per_page)
    
    # Статистика для sidebar
    @total_photos = current_user.images.input.not_deleted.count
    @unfiled_count = current_user.images.input.not_deleted.where(room_type: [nil, ""]).count
    @trash_count = current_user.images.input.deleted.count
    
    # Список папок с количеством фото
    @folders = [
      { name: "Living Room", slug: "living_room", icon: "🛋️", count: current_user.images.input.not_deleted.where(room_type: "living_room").count },
      { name: "Bedroom", slug: "bedroom", icon: "🛏️", count: current_user.images.input.not_deleted.where(room_type: "bedroom").count },
      { name: "Dining Room", slug: "dining_room", icon: "🍽️", count: current_user.images.input.not_deleted.where(room_type: "dining_room").count },
      { name: "Kitchen", slug: "kitchen", icon: "🍳", count: current_user.images.input.not_deleted.where(room_type: "kitchen").count },
      { name: "Bathroom", slug: "bathroom", icon: "🚿", count: current_user.images.input.not_deleted.where(room_type: "bathroom").count },
      { name: "Office", slug: "office", icon: "💼", count: current_user.images.input.not_deleted.where(room_type: "office").count },
      { name: "Main Area", slug: "main_area", icon: "🏠", count: current_user.images.input.not_deleted.where(room_type: "main_area").count }
    ]
    
    # Баланс токенов
    @token_balance = current_user.token_balance
  end
end

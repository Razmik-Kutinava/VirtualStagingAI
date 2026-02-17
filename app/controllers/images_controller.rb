class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:soft_delete, :restore, :destroy, :modal, :style_selection]

  # Soft delete - переместить в корзину
  def soft_delete
    if @image.update(deleted_at: Time.current)
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Фото перемещено в корзину" }
        format.json { render json: { success: true, message: "Фото перемещено в корзину" } }
        format.turbo_stream { 
          render turbo_stream: turbo_stream.remove("image_#{@image.id}")
        }
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer || dashboard_path, alert: "Не удалось удалить фото" }
        format.json { render json: { success: false, errors: @image.errors.full_messages } }
      end
    end
  end

  # Восстановить из корзины
  def restore
    @image.update(deleted_at: nil)
    folder = @image.folder_id.presence&.to_s || 'all'
    
    respond_to do |format|
      format.html { redirect_to dashboard_path(folder: folder), notice: "Фото восстановлено" }
      format.turbo_stream {
        redirect_to dashboard_path(folder: folder)
      }
    end
  end

  # Hard delete - удалить навсегда
  def destroy
    @image.destroy
    
    respond_to do |format|
      format.html { redirect_to dashboard_path(folder: 'trash'), notice: "Фото удалено навсегда" }
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove("image_#{@image.id}")
      }
    end
  end

  # Модалка для просмотра изображения
  def modal
    @generations = @image.input_generations.includes(:style, :output_image).order(created_at: :desc)
    
    respond_to do |format|
      format.html { render partial: 'projects/image_modal', layout: false }
      format.json { render json: { success: true } }
    end
  end

  # Модалка для выбора стиля
  def style_selection
    # Получаем только основные 4 стиля
    @styles = Style.where(name: ['БАЗОВЫЙ', 'МОДЕРН', 'МИД-СЕНЧУРИ', 'СКАНДИ']).order(
      Arel.sql("CASE name 
        WHEN 'БАЗОВЫЙ' THEN 1
        WHEN 'МОДЕРН' THEN 2
        WHEN 'МИД-СЕНЧУРИ' THEN 3
        WHEN 'СКАНДИ' THEN 4
        ELSE 5
      END")
    )
    
    # Если стилей нет, создаем их
    if @styles.empty?
      @styles = [
        Style.find_or_create_by!(name: 'БАЗОВЫЙ') { |s| s.prompt = 'Empty room, neutral colors, natural light, minimal furniture, clean space' },
        Style.find_or_create_by!(name: 'МОДЕРН') { |s| s.prompt = 'Modern interior, clean lines, minimal furniture, neutral palette, contemporary design' },
        Style.find_or_create_by!(name: 'МИД-СЕНЧУРИ') { |s| s.prompt = 'Mid-century modern, retro furniture, warm wood tones, geometric patterns, vintage style' },
        Style.find_or_create_by!(name: 'СКАНДИ') { |s| s.prompt = 'Scandinavian style, light colors, cozy, minimal, natural materials, hygge atmosphere' }
      ]
    end
    
    respond_to do |format|
      format.html { render partial: 'projects/style_selection_modal', layout: false }
      format.json { render json: { success: true, styles: @styles.map { |s| { id: s.id, name: s.name } } } }
    end
  rescue => e
    Rails.logger.error "Error in style_selection: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    
    respond_to do |format|
      format.html { render plain: "Ошибка загрузки стилей: #{e.message}", status: :internal_server_error }
      format.json { render json: { success: false, error: e.message }, status: :internal_server_error }
    end
  end

  private

  def set_image
    @image = current_user.images.find(params[:id])
  end
end

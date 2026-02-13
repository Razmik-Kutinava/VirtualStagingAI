class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:soft_delete, :restore, :destroy, :modal]

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

  private

  def set_image
    @image = current_user.images.find(params[:id])
  end
end

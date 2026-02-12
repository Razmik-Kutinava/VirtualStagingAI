class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show]

  def new
    @image = current_user.images.build(kind: :input)
  end

  def create
    @image = current_user.images.build(image_params.merge(kind: :input))
    
    if @image.save
      redirect_to project_path(@image), notice: "Фото успешно загружено"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @generations = @image.input_generations.includes(:style, :output_image).order(created_at: :desc)
  end

  private

  def set_image
    @image = current_user.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:file, :room_type)
  end
end

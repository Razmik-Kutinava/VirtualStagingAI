class LandingController < ApplicationController
  def index
    # Если пользователь авторизован, перенаправляем на dashboard
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
end

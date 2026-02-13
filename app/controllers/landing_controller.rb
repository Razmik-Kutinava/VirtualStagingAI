class LandingController < ApplicationController
  # Отключаем layout, так как лендинг содержит полный HTML документ
  layout false
  
  def index
    # Временно отключен редирект для тестирования лендинга
    # if user_signed_in?
    #   redirect_to dashboard_path
    # end
    
    # Получаем активные тарифы, отсортированные по цене
    @token_packages = TokenPackage.where(active: true).order(:price_cents)
  end
end

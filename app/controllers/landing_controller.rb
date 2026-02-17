class LandingController < ApplicationController
  # Отключаем layout, так как лендинг содержит полный HTML документ
  layout false
  
  def index
    # Временно отключен редирект для тестирования лендинга
    # if user_signed_in?
    #   redirect_to dashboard_path
    # end
    
    # Получаем активные тарифы, отсортированные по цене
    # Обрабатываем ошибки БД на случай, если база данных не готова
    begin
      @token_packages = TokenPackage.where(active: true).order(:price_cents)
    rescue ActiveRecord::StatementInvalid, ActiveRecord::ConnectionNotEstablished, ActiveRecord::NoDatabaseError => e
      Rails.logger.error "Database error in LandingController#index: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      @token_packages = []
    rescue => e
      Rails.logger.error "Unexpected error in LandingController#index: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      @token_packages = []
    end
  end
end

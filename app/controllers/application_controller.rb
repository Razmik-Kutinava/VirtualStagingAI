class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Include Devise helpers
  include Devise::Controllers::Helpers
  
  # Make Devise helpers available in views
  helper_method :user_signed_in?, :current_user, :user_session

  # Устанавливаем текущего пользователя и IP-адрес для аудит-логов
  # ИСКЛЮЧАЕМ RailsAdmin, чтобы не мешать его работе
  around_action :set_current_user, unless: -> { request.path.start_with?('/admin') }

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_current_user
    Current.user = current_user
    Current.ip_address = request.remote_ip
    yield
  ensure
    Current.user = nil
    Current.ip_address = nil
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
  end
end

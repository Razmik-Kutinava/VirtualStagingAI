# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end

    # POST /resource/confirmation
    # def create
    #   super
    # end

    # GET /resource/confirmation?confirmation_token=abcdef
    # def show
    #   super
    # end

    protected

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      # После подтверждения email пользователь автоматически входит в систему
      # Перенаправляем на dashboard
      dashboard_path
    end
  end
end

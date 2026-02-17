# frozen_string_literal: true

class RailsAdmin::InlineEditsController < ApplicationController
    # Защита от CSRF для AJAX запросов
    protect_from_forgery with: :exception, prepend: true
    
    # Разрешаем JSON запросы
    skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
    
    before_action :authenticate_user!
    before_action :check_admin_access
    before_action :load_model_and_record
    
    # Обновление одного поля записи
    def update_field
      field_name = params[:field_name]
      field_value = params[:field_value]
      
      # Проверяем, что поле разрешено для редактирования
      unless editable_field?(field_name)
        render json: { 
          success: false, 
          error: "Field '#{field_name}' is not editable inline" 
        }, status: :forbidden
        return
      end
      
      # Сохраняем старое значение для отката
      old_value = @record.send(field_name)
      
      # Обновляем поле
      if @record.update(field_name => field_value)
        render json: {
          success: true,
          field_name: field_name,
          field_value: format_field_value(@record, field_name),
          old_value: old_value,
          message: 'Field updated successfully'
        }
      else
        render json: {
          success: false,
          errors: @record.errors.full_messages,
          field_name: field_name
        }, status: :unprocessable_entity
      end
    rescue StandardError => e
      Rails.logger.error "Inline edit error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      
      render json: {
        success: false,
        error: e.message
      }, status: :internal_server_error
    end
    
    private
    
    def check_admin_access
      unless current_user&.admin?
        render json: { 
          success: false, 
          error: 'Access denied' 
        }, status: :forbidden
      end
    end
    
    def load_model_and_record
      model_name = params[:model_name]
      record_id = params[:id]
      
      # Получаем класс модели из имени (учитываем, что в URL может быть user, а модель User)
      begin
        model_class = model_name.classify.constantize
      rescue NameError => e
        Rails.logger.error "Model class not found: #{model_name} - #{e.message}"
        render json: { 
          success: false, 
          error: "Model '#{model_name}' not found" 
        }, status: :not_found
        return
      end
      
      unless model_class < ActiveRecord::Base
        render json: { 
          success: false, 
          error: "Model '#{model_name}' is not an ActiveRecord model" 
        }, status: :not_found
        return
      end
      
      # Загружаем запись
      begin
        @record = model_class.find(record_id)
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.error "Record not found: #{model_name}##{record_id} - #{e.message}"
        render json: { 
          success: false, 
          error: "Record with id #{record_id} not found" 
        }, status: :not_found
        return
      end
      
      @model_class = model_class
    end
    
    # Проверяем, можно ли редактировать поле inline
    def editable_field?(field_name)
      # Исключаем системные поля
      return false if %w[id created_at updated_at].include?(field_name)
      
      # Исключаем пароли
      return false if field_name.include?('password')
      
      # Исключаем зашифрованные поля
      return false if field_name.include?('encrypted')
      
      # Исключаем токены
      return false if field_name.include?('token')
      
      # Проверяем, что поле существует в модели
      return false unless @record.respond_to?("#{field_name}=")
      
      # Проверяем, что это не связь (belongs_to, has_many и т.д.)
      # Для связей нужна особая обработка
      association = @model_class.reflect_on_association(field_name.to_sym)
      return false if association && association.macro != :belongs_to
      
      true
    end
    
    # Форматируем значение поля для отображения
    def format_field_value(record, field_name)
      value = record.send(field_name)
      
      # Для enum возвращаем строковое значение
      if record.class.respond_to?(:defined_enums) && record.class.defined_enums.key?(field_name)
        return record.class.defined_enums[field_name].key(value) || value.to_s
      end
      
      # Для дат форматируем
      if value.is_a?(Time) || value.is_a?(Date) || value.is_a?(DateTime)
        return value.strftime('%B %d, %Y %H:%M')
      end
      
      # Для boolean возвращаем строку
      return value.to_s if value.is_a?(TrueClass) || value.is_a?(FalseClass)
      
      # Остальное как есть
      value.to_s
    end
end

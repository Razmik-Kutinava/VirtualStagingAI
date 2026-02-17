class RailsAdmin::ReportsController < ApplicationController
  protect_from_forgery with: :exception, prepend: true
  
  before_action :authenticate_user!
  before_action :check_admin_access
  
  # Финансовый отчет
  def financial_report
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : 1.month.ago
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today
    
    @revenue = Payment.where(status: 'succeeded', created_at: start_date..end_date.end_of_day)
                     .sum(:amount_cents) / 100.0
    
    @expenses = TokenTransaction.where(operation: 'spend', created_at: start_date..end_date.end_of_day)
                                .sum(:amount) || 0
    
    @profit = @revenue - @expenses
    
    @payments_count = Payment.where(status: 'succeeded', created_at: start_date..end_date.end_of_day).count
    @transactions_count = TokenTransaction.where(created_at: start_date..end_date.end_of_day).count
    
    respond_to do |format|
      format.html
      format.csv { send_data generate_financial_csv, filename: "financial_report_#{start_date}_#{end_date}.csv" }
      format.xlsx { send_data generate_financial_xlsx, filename: "financial_report_#{start_date}_#{end_date}.xlsx" }
    end
  end
  
  # Отчет по активности пользователей
  def user_activity_report
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : 1.month.ago
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today
    
    @users = User.includes(:projects, :generations, :token_transactions)
                 .where(created_at: start_date..end_date.end_of_day)
                 .map do |user|
      {
        user: user,
        projects_count: user.projects.where(created_at: start_date..end_date.end_of_day).count,
        generations_count: user.generations.where(created_at: start_date..end_date.end_of_day).count,
        tokens_spent: user.token_transactions.where(operation: 'spend', created_at: start_date..end_date.end_of_day).sum(:amount) || 0,
        last_activity: [user.projects.maximum(:created_at), user.generations.maximum(:created_at)].compact.max
      }
    end.sort_by { |u| -u[:generations_count] }
    
    respond_to do |format|
      format.html
      format.csv { send_data generate_user_activity_csv, filename: "user_activity_#{start_date}_#{end_date}.csv" }
      format.xlsx { send_data generate_user_activity_xlsx, filename: "user_activity_#{start_date}_#{end_date}.xlsx" }
    end
  end
  
  # Отчет по генерациям
  def generation_report
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : 1.month.ago
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today
    
    @generations = Generation.includes(:user, :style)
                             .where(created_at: start_date..end_date.end_of_day)
    
    @by_status = @generations.group(:status).count
    @by_style = @generations.group(:style_id).count
    @total_tokens = @generations.sum(:tokens_spent) || 0
    
    respond_to do |format|
      format.html
      format.csv { send_data generate_generation_csv, filename: "generation_report_#{start_date}_#{end_date}.csv" }
      format.xlsx { send_data generate_generation_xlsx, filename: "generation_report_#{start_date}_#{end_date}.xlsx" }
    end
  end
  
  private
  
  def check_admin_access
    unless current_user&.admin?
      redirect_to main_app.root_path, alert: 'Access denied'
    end
  end
  
  def generate_financial_csv
    require 'csv'
    CSV.generate(headers: true) do |csv|
      csv << ['Период', 'Доход (₽)', 'Расходы (токены)', 'Прибыль (₽)', 'Количество платежей', 'Количество транзакций']
      csv << [
        "#{params[:start_date]} - #{params[:end_date]}",
        @revenue,
        @expenses,
        @profit,
        @payments_count,
        @transactions_count
      ]
    end
  end
  
  def generate_financial_xlsx
    require 'caxlsx'
    package = Axlsx::Package.new
    workbook = package.workbook
    
    workbook.add_worksheet(name: "Финансовый отчет") do |sheet|
      sheet.add_row ['Период', 'Доход (₽)', 'Расходы (токены)', 'Прибыль (₽)', 'Количество платежей', 'Количество транзакций']
      sheet.add_row [
        "#{params[:start_date]} - #{params[:end_date]}",
        @revenue,
        @expenses,
        @profit,
        @payments_count,
        @transactions_count
      ]
    end
    
    package.to_stream.read
  end
  
  def generate_user_activity_csv
    require 'csv'
    CSV.generate(headers: true) do |csv|
      csv << ['Email', 'Проектов', 'Генераций', 'Потрачено токенов', 'Последняя активность']
      @users.each do |u|
        csv << [
          u[:user].email,
          u[:projects_count],
          u[:generations_count],
          u[:tokens_spent],
          u[:last_activity]&.strftime('%d.%m.%Y %H:%M')
        ]
      end
    end
  end
  
  def generate_user_activity_xlsx
    require 'caxlsx'
    package = Axlsx::Package.new
    workbook = package.workbook
    
    workbook.add_worksheet(name: "Активность пользователей") do |sheet|
      sheet.add_row ['Email', 'Проектов', 'Генераций', 'Потрачено токенов', 'Последняя активность']
      @users.each do |u|
        sheet.add_row [
          u[:user].email,
          u[:projects_count],
          u[:generations_count],
          u[:tokens_spent],
          u[:last_activity]&.strftime('%d.%m.%Y %H:%M')
        ]
      end
    end
    
    package.to_stream.read
  end
  
  def generate_generation_csv
    require 'csv'
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Пользователь', 'Стиль', 'Статус', 'Токенов потрачено', 'Дата создания']
      @generations.each do |gen|
        csv << [
          gen.id,
          gen.user.email,
          gen.style.name,
          gen.status,
          gen.tokens_spent,
          gen.created_at.strftime('%d.%m.%Y %H:%M')
        ]
      end
    end
  end
  
  def generate_generation_xlsx
    require 'caxlsx'
    package = Axlsx::Package.new
    workbook = package.workbook
    
    workbook.add_worksheet(name: "Отчет по генерациям") do |sheet|
      sheet.add_row ['ID', 'Пользователь', 'Стиль', 'Статус', 'Токенов потрачено', 'Дата создания']
      @generations.each do |gen|
        sheet.add_row [
          gen.id,
          gen.user.email,
          gen.style.name,
          gen.status,
          gen.tokens_spent,
          gen.created_at.strftime('%d.%m.%Y %H:%M')
        ]
      end
    end
    
    package.to_stream.read
  end
end

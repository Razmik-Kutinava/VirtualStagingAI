class RailsAdmin::StatisticsController < ApplicationController
  protect_from_forgery with: :exception, prepend: true
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  
  before_action :authenticate_user!
  before_action :check_admin_access
  
  # График регистраций пользователей
  def user_registrations
    period = params[:period] || 'week'
    data = calculate_user_registrations(period)
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # График создания проектов
  def projects
    period = params[:period] || 'week'
    data = calculate_projects(period)
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # График доходов
  def revenue
    period = params[:period] || 'week'
    data = calculate_revenue(period)
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # График активности
  def activity
    period = params[:period] || 'week'
    data = calculate_activity(period)
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # Воронка конверсии
  def conversion
    data = calculate_conversion_funnel
    
    render json: {
      labels: data[:labels],
      values: data[:values],
      percentages: data[:percentages]
    }
  end
  
  # Статистика пакетов токенов
  def token_packages
    data = calculate_token_packages_stats
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # Статистика по стилям
  def styles
    data = calculate_styles_stats
    
    render json: {
      labels: data[:labels],
      values: data[:values]
    }
  end
  
  # Топ пользователей по активности
  def top_users
    limit = params[:limit] || 10
    users = User.includes(:projects, :generations, :token_transactions)
                .joins("LEFT JOIN projects ON projects.user_id = users.id")
                .joins("LEFT JOIN generations ON generations.user_id = users.id")
                .select('users.*, COUNT(DISTINCT projects.id) as projects_count, COUNT(DISTINCT generations.id) as generations_count')
                .group('users.id')
                .order('projects_count DESC, generations_count DESC')
                .limit(limit)
    
    data = users.map do |user|
      {
        id: user.id,
        email: user.email,
        projects_count: user.projects_count,
        generations_count: user.generations_count,
        tokens_spent: user.token_transactions.where(operation: 'spend').sum(:amount) || 0,
        token_balance: user.token_balance
      }
    end
    
    render json: { users: data }
  end
  
  private
  
  def check_admin_access
    unless current_user&.admin?
      render json: { error: 'Access denied' }, status: :forbidden
    end
  end
  
  def calculate_user_registrations(period)
    cache_key = "user_registrations_#{period}_#{Date.today}"
    Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      date_range = get_date_range(period)
      step = get_step(period)
      
      data = User.where(created_at: date_range)
                 .group_by_period(step, :created_at, format: get_date_format(period))
                 .count
      
      {
        labels: data.keys,
        values: data.values
      }
    end
  end
  
  def calculate_projects(period)
    cache_key = "projects_#{period}_#{Date.today}"
    Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      date_range = get_date_range(period)
      step = get_step(period)
      
      data = Project.where(created_at: date_range)
                    .group_by_period(step, :created_at, format: get_date_format(period))
                    .count
      
      {
        labels: data.keys,
        values: data.values
      }
    end
  end
  
  def calculate_revenue(period)
    cache_key = "revenue_#{period}_#{Date.today}"
    Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      date_range = get_date_range(period)
      step = get_step(period)
      
      data = Payment.where(status: 'succeeded', created_at: date_range)
                    .group_by_period(step, :created_at, format: get_date_format(period))
                    .sum('amount_cents / 100.0')
      
      {
        labels: data.keys,
        values: data.values.map(&:to_f)
      }
    end
  end
  
  def calculate_activity(period)
    date_range = get_date_range(period)
    step = get_step(period)
    
    # Комбинированная активность: регистрации + проекты + генерации
    users_data = User.where(created_at: date_range)
                     .group_by_period(step, :created_at, format: get_date_format(period))
                     .count
    
    projects_data = Project.where(created_at: date_range)
                           .group_by_period(step, :created_at, format: get_date_format(period))
                           .count
    
    generations_data = Generation.where(created_at: date_range)
                                 .group_by_period(step, :created_at, format: get_date_format(period))
                                 .count
    
    # Объединяем все даты
    all_dates = (users_data.keys + projects_data.keys + generations_data.keys).uniq.sort
    
    values = all_dates.map do |date|
      (users_data[date] || 0) + (projects_data[date] || 0) + (generations_data[date] || 0)
    end
    
    {
      labels: all_dates,
      values: values
    }
  end
  
  def calculate_conversion_funnel
    total_registrations = User.count
    confirmed_users = User.where.not(confirmed_at: nil).count
    users_with_purchases = User.joins(:token_purchases).distinct.count
    users_with_generations = User.joins(:generations).distinct.count
    
    values = [total_registrations, confirmed_users, users_with_purchases, users_with_generations]
    labels = ['Регистрации', 'Подтвержденные', 'С покупками', 'С генерациями']
    
    percentages = values.map.with_index do |val, idx|
      prev_val = idx > 0 ? values[idx - 1] : val
      prev_val > 0 ? ((val.to_f / prev_val) * 100).round(1) : 0
    end
    
    {
      labels: labels,
      values: values,
      percentages: percentages
    }
  end
  
  def calculate_token_packages_stats
    packages = TokenPackage.includes(:token_purchases)
    
    labels = packages.map(&:name)
    values = packages.map { |pkg| pkg.token_purchases.count }
    
    {
      labels: labels,
      values: values
    }
  end
  
  def calculate_styles_stats
    styles = Style.includes(:generations)
    
    labels = styles.map(&:name)
    values = styles.map { |style| style.generations.count }
    
    # Сортируем по популярности
    sorted_data = labels.zip(values).sort_by { |_, count| -count }
    
    {
      labels: sorted_data.map(&:first),
      values: sorted_data.map(&:last)
    }
  end
  
  def get_date_range(period)
    case period
    when 'day'
      1.day.ago..Time.current
    when 'week'
      7.days.ago..Time.current
    when 'month'
      1.month.ago..Time.current
    when 'year'
      1.year.ago..Time.current
    else
      7.days.ago..Time.current
    end
  end
  
  def get_step(period)
    case period
    when 'day'
      :hour
    when 'week'
      :day
    when 'month'
      :day
    when 'year'
      :month
    else
      :day
    end
  end
  
  def get_date_format(period)
    case period
    when 'day'
      '%H:%M'
    when 'week', 'month'
      '%d.%m'
    when 'year'
      '%m.%Y'
    else
      '%d.%m'
    end
  end
end

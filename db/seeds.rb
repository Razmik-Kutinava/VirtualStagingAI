# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# ============================================
# ПАКЕТЫ ТОКЕНОВ (ТАРИФЫ) VSAI
# ============================================

token_packages = [
  {
    name: "СТАРТОВЫЙ",
    tokens_amount: 20,
    price_cents: 1900,  # $19 = 1900 центов
    description: "20 токенов — для пробного стайлинга. Подойдет, чтобы попробовать сервис.",
    active: true,
    validity_days: nil  # Бессрочные
  },
  {
    name: "БАЗОВЫЙ",
    tokens_amount: 60,
    price_cents: 4900,  # $49 = 4900 центов
    description: "60 токенов — оптимальный выбор. Multi-view стайлинг и приоритетная обработка.",
    active: true,
    validity_days: nil  # Бессрочные
  },
  {
    name: "ПРОФИ",
    tokens_amount: 150,
    price_cents: 9900,  # $99 = 9900 центов
    description: "150 токенов — для активных агентов. VIP поддержка и API доступ.",
    active: true,
    validity_days: nil  # Бессрочные
  },
  {
    name: "АГЕНТСКИЙ",
    tokens_amount: 500,
    price_cents: 29900,  # $299 = 29900 центов
    description: "500 токенов — для агентств. White-label опция и командный доступ до 5 человек.",
    active: true,
    validity_days: nil  # Бессрочные
  }
]

puts "Создание пакетов токенов..."
token_packages.each do |package_data|
  package = TokenPackage.find_or_initialize_by(name: package_data[:name])
  package.assign_attributes(package_data)
  if package.save
    puts "  ✓ Создан/обновлен: #{package.name}"
  else
    puts "  ✗ Ошибка при создании #{package_data[:name]}: #{package.errors.full_messages.join(', ')}"
  end
end

# ============================================
# СТИЛИ ИНТЕРЬЕРОВ
# ============================================

styles = [
  { 
    name: "БАЗОВЫЙ", 
    prompt: "Empty room, neutral colors, natural light, minimal furniture, clean space" 
  },
  { 
    name: "МОДЕРН", 
    prompt: "Modern interior, clean lines, minimal furniture, neutral palette, contemporary design" 
  },
  { 
    name: "МИД-СЕНЧУРИ", 
    prompt: "Mid-century modern, retro furniture, warm wood tones, geometric patterns, vintage style" 
  },
  { 
    name: "СКАНДИ", 
    prompt: "Scandinavian style, light colors, cozy, minimal, natural materials, hygge atmosphere" 
  },
  { 
    name: "ИНДАСТРИАЛ", 
    prompt: "Industrial style, raw materials, concrete, metal, exposed brick, urban loft" 
  },
  { 
    name: "ЛЮКС", 
    prompt: "Luxury interior, elegant furniture, gold accents, premium materials, sophisticated design" 
  },
  { 
    name: "ПОБЕРЕЖЬЕ", 
    prompt: "Coastal style, beach house, light blue, white, natural textures, relaxed atmosphere" 
  },
  { 
    name: "ФЕРМХАУС", 
    prompt: "Farmhouse style, rustic, wooden elements, cozy, country charm, vintage decor" 
  }
]

puts "\nСоздание стилей интерьеров..."
styles.each do |style_data|
  style = Style.find_or_initialize_by(name: style_data[:name])
  style.prompt = style_data[:prompt] if style.prompt.blank?
  if style.save
    puts "  ✓ Создан/обновлен: #{style.name}"
  else
    puts "  ✗ Ошибка при создании #{style_data[:name]}: #{style.errors.full_messages.join(', ')}"
  end
end

# ============================================
# ТЕСТОВЫЙ ПОЛЬЗОВАТЕЛЬ (ОПЦИОНАЛЬНО)
# ============================================

if Rails.env.development?
  puts "\nСоздание тестового пользователя..."
  test_user = User.find_or_initialize_by(email: "test@vsai.ru")
  if test_user.new_record?
    test_user.password = "password123"
    test_user.password_confirmation = "password123"
    test_user.confirmed_at = Time.current
    if test_user.save
      puts "  ✓ Создан тестовый пользователь: test@vsai.ru / password123"
    else
      puts "  ✗ Ошибка при создании пользователя: #{test_user.errors.full_messages.join(', ')}"
    end
  else
    puts "  ✓ Тестовый пользователь уже существует: test@vsai.ru"
  end
end

# ============================================
# ПЕРВЫЙ АДМИНИСТРАТОР
# ============================================

admin_email = 'admin@vsai.ru'
admin_password = 'Admin123!' # Надежный пароль

unless User.exists?(email: admin_email)
  admin = User.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password,
    role: :admin,
    confirmed_at: Time.current # Автоматически подтверждаем email для Devise
  )
  
  # Выводим данные жирным шрифтом, чтобы было видно
  puts "\n" + "=" * 60
  puts "🔥 АДМИНИСТРАТОР УСПЕШНО СОЗДАН!"
  puts "=" * 60
  puts "📧 Email:    #{admin_email}"
  puts "🔑 Пароль:   #{admin_password}"
  puts "🌐 URL входа: http://localhost:3000/users/sign_in"
  puts "🛠️  Админка:  http://localhost:3000/admin"
  puts "=" * 60 + "\n\n"
else
  puts "\n⚠️  Администратор с email #{admin_email} уже существует"
end

puts "\n✅ Seeds выполнены успешно!"

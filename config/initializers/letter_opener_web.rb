# Загрузка letter_opener_web для development окружения
if Rails.env.development?
  begin
    require 'letter_opener_web'
  rescue LoadError => e
    Rails.logger.warn "LetterOpenerWeb gem не найден: #{e.message}" if defined?(Rails.logger)
  end
end

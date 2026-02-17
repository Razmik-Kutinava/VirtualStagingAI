class AuditLogger
  def self.log(user, action, details = {})
    return unless user

    AuditLog.create(
      user: user,
      action: action,
      details: details,
      ip_address: Current.ip_address
    )
  rescue => e
    Rails.logger.error "Failed to create audit log: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
  end
end

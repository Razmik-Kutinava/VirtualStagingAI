class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.references :user, null: true, foreign_key: true
      t.string :action
      t.json :details
      t.string :ip_address

      t.timestamps
    end
  end
end

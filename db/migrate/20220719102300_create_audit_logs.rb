class CreateAuditLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :audit_logs do |t|
      t.string  :action, null: false
      t.json    :audit_changes

      # Set auditable_type & auditable_id
      t.references :auditable, polymorphic: true, index: true

      t.timestamps
    end
  end
end

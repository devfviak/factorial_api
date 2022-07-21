# frozen_string_literal: true

# == Schema Information
#
# Table name: audit_logs
#
#  id             :bigint           not null, primary key
#  action         :string(255)      not null
#  audit_changes  :json
#  auditable_type :string(255)
#  auditable_id   :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true

  validates :action, :auditable_type, presence: true

  scope :by_action, ->(action) { where(action:) }
end

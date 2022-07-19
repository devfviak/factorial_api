# frozen_string_literal: true

class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true

  validates :action, :auditable_type, presence: true

  scope :by_action, ->(action) { where(action:) }
end

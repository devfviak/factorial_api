# frozen_string_literal: true

# Possible alternative: Use Audited gem
# https://github.com/collectiveidea/audited

module Auditable
  extend ActiveSupport::Concern

  EXCLUDED_COLUMNS = %w[created_at updated_at].freeze

  included do
    has_many :audit_logs, as: :auditable, dependent: nil

    scope :updates, -> { where(auditable_id: id, action: :update) }
    scope :creations, -> { where(auditable_id: id, action: :create) }

    # On update callback
    after_update do
      track_audit(:update, changes: saved_changes)
    end

    after_create do
      track_audit(:create, changes: saved_changes)
    end

    # TODO: Maybe in next versions
    # Problems to handle: auditable deletion and dependent
    # after_destroy do
    #   track_audit(:destroy, before: self)
    # end

    private

    def track_audit(action, changes:)
      audit_changes = clean_audit_changes(changes)
      AuditLog.create!(auditable: self, action:, audit_changes:)
    end

    def clean_audit_changes(changes)
      changes.filter { |column, _values| EXCLUDED_COLUMNS.exclude?(column) }
    end
  end
end

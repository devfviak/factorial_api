require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  it { is_expected.to validate_presence_of :action }
  it { is_expected.to belong_to :auditable }
  it { is_expected.to validate_presence_of :auditable_type }
end

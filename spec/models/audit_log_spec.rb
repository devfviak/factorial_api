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
require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  it { is_expected.to validate_presence_of :action }
  it { is_expected.to belong_to :auditable }
  it { is_expected.to validate_presence_of :auditable_type }
end

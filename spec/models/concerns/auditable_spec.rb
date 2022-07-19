# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'auditable' do
  it { is_expected.to have_many(:audit_logs) }

  describe '#on update' do
    it 'has an audit_log' do
      user = create(:user)
      expect { user.update!(first_name: 'Updated name') }.to change(AuditLog, :count).by(1)
    end

    it "marks the audit action as 'updated'" do
      user = create(:user)
      user.update!(first_name: 'Updated name again')
      expect(user.audit_logs.last.action).to eq('update')
    end

    it 'stores the changes in attributes' do
      user = create(:user)

      user.update!(first_name: 'Last updated name')
      expected_changes = user.saved_changes.filter do |column, _value|
        described_class::EXCLUDED_COLUMNS.exclude?(column)
      end

      expect(user.audit_logs.last.audit_changes).to eq(expected_changes)
    end
  end
end

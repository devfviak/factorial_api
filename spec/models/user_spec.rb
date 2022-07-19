require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation tests
  describe 'validations' do
    subject { create(:user) }

    it_behaves_like 'auditable'

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password_digest }
    it { is_expected.to validate_presence_of :phone }

    it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(50) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }
  end
end

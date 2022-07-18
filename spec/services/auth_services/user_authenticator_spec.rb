# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthServices::UserAuthenticator do
  # valid request subject

  # Test Suite for UserAuthenticator#call
  describe '#call' do
    let(:user) { create(:user) }

    context 'when valid credentials' do
      it 'returns user jwt' do
        user_jwt = described_class.call(user.email, user.password)
        expect(user_jwt).to eq token_generator(user.id)
      end
    end

    context 'when invalid credentials' do
      it 'throws Exceptions::InvalidCredentials' do
        expect do
          described_class.call(user.email, "bad_#{user.password}")
        end.to raise_exception(Exceptions::InvalidCredentials)
      end
    end
  end
end

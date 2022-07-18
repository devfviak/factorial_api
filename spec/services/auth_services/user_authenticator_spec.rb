# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthServices::UserAuthenticator do
  # valid request subject

  # Test Suite for UserAuthenticator#call
  describe '#call' do
    let(:user) { create(:user) }

    context 'when valid credentials' do
      subject(:valid_credentials_authenticator) { described_class.new(user.email, user.password) }

      it 'returns user jwt' do
        user_jwt = valid_credentials_authenticator.call

        expect(user_jwt).to eq token_generator(user.id)
      end
    end

    context 'when invalid credentials' do
      subject(:invalid_credentials_authenticator) { described_class.new(user.email, "bad_#{user.password}") }

      it 'throws Exceptions::InvalidCredentials' do
        expect { invalid_credentials_authenticator.call }.to raise_exception(Exceptions::InvalidCredentials)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthServices::RequestAuthenticator do
  # Test Suite for RequestAuthenticator#call
  describe '#call' do
    context 'when valid request' do
      subject(:request_authenticator) { described_class.new(valid_headers) }

      let(:user) { create(:user) }
      let(:headers) { valid_headers }

      it 'returns user' do
        user_result = request_authenticator.call
        expect(user_result).to eq user
      end
    end

    context 'when missing token request' do
      subject(:request_authenticator) { described_class.new({}) }

      let(:user) { create(:user) }

      it 'throws Exceptions::MissingToken' do
        expect { request_authenticator.call }.to raise_exception(Exceptions::MissingToken)
      end
    end

    context 'when fake token request' do
      subject(:request_authenticator) { described_class.new({ 'Authorization' => 'foo' }) }

      let(:user) { create(:user) }

      it 'throws Exceptions::InvalidToken' do
        expect { request_authenticator.call }.to raise_exception(Exceptions::InvalidToken)
      end
    end

    context 'when expired token request' do
      subject(:request_authenticator) { described_class.new({ 'Authorization' => expired_token_generator(user.id) }) }

      let(:user) { create(:user) }

      it 'throws Exceptions::ExpiredToken' do
        expect { request_authenticator.call }.to raise_exception(Exceptions::ExpiredToken)
      end
    end
  end
end

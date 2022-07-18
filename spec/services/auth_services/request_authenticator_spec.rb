# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthServices::RequestAuthenticator do
  # Test Suite for RequestAuthenticator#call
  describe '#call' do
    context 'when valid request' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }

      it 'returns user' do
        user_result = described_class.call(valid_headers)
        expect(user_result).to eq user
      end
    end

    context 'when missing token request' do
      let(:user) { create(:user) }

      it 'throws Exceptions::MissingToken' do
        expect { described_class.call({}) }.to raise_exception(Exceptions::MissingToken)
      end
    end

    context 'when fake token request' do
      let(:user) { create(:user) }

      it 'throws Exceptions::InvalidToken' do
        expect { described_class.call({ 'Authorization' => 'foo' }) }.to raise_exception(Exceptions::InvalidToken)
      end
    end

    context 'when expired token request' do
      let(:user) { create(:user) }

      it 'throws Exceptions::ExpiredToken' do
        expect do
          described_class.call({ 'Authorization' => expired_token_generator(user.id) })
        end.to raise_exception(Exceptions::ExpiredToken)
      end
    end
  end
end

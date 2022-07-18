# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthServices::RequestAuthenticator do
  # Test Suite for RequestAuthenticator#call
  describe '#call' do
    let(:user) { create(:user) }

    context 'when valid request' do
      it 'returns user' do
        user_result = described_class.call(token_generator(user.id))
        expect(user_result).to eq user
      end
    end

    context 'when fake token request' do
      it 'throws Exceptions::InvalidToken' do
        expect { described_class.call('fake') }.to raise_exception(Exceptions::InvalidToken)
      end
    end

    context 'when expired token request' do
      it 'throws Exceptions::ExpiredToken' do
        expect do
          described_class.call(expired_token_generator(user.id))
        end.to raise_exception(Exceptions::ExpiredToken)
      end
    end
  end
end

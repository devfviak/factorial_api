# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  let(:return_url) { 'http://google.com' }

  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_params) { { user: valid_attributes, return_url: }.to_json }

  describe 'POST /users' do
    context 'when valid signup request' do
      before { post '/users', params: valid_params, headers: }

      it 'creates a new user' do
        expect(user.errors).to be_empty
      end

      it 'returns an authentication token in cookies response' do
        expect(cookies[:auth_token]).not_to be_nil
      end

      it 'redirects to return_url in params' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when invalid signup request with missing params' do
      before { post '/users', params: {}, headers: }

      it 'responds with Bad Request error' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns nothing in cookies response' do
        expect(cookies[:auth_token]).to be_nil
      end
    end

    context 'when already existing user' do
      let(:user) { create(:user) }

      before { post '/users', params: valid_params, headers: }

      it 'responds with Unprocessable Entity error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns nothing in cookies response' do
        expect(cookies[:auth_token]).to be_nil
      end
    end
  end
end

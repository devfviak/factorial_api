# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  let(:return_url) { 'http://google.com' }
  let(:valid_params) { { user: valid_attributes, return_url: } }

  # CREATE USER TESTS
  describe 'POST /users' do
    context 'when valid signup request' do
      subject(:make_request) { post '/users', params: valid_params, as: :json }

      it 'creates a new user' do
        expect { make_request }.to change(User, :count).by(1)
      end

      it 'returns an authentication token in cookies response' do
        make_request
        expect(cookies[:auth_token]).not_to be_nil
      end

      it 'redirects to return_url in params' do
        make_request
        expect(response).to have_http_status(:found)
      end
    end

    context 'when invalid signup request with missing params' do
      subject(:make_request) { post '/users', params: {}, as: :json }

      it 'responds with Bad Request error' do
        make_request
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create a new user' do
        expect { make_request }.not_to change(User, :count)
      end

      it 'returns nothing in cookies response' do
        make_request
        expect(cookies[:auth_token]).to be_nil
      end
    end

    context 'when already existing user' do
      subject(:make_request) { post '/users', params: valid_params, as: :json }

      before { create(:user) }

      it 'responds with Unprocessable Entity error' do
        make_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new user' do
        expect { make_request }.not_to change(User, :count)
      end

      it 'returns nothing in cookies response' do
        make_request
        expect(cookies[:auth_token]).to be_nil
      end
    end
  end

  # FETCH USER TESTS
  describe 'GET /users/me' do
    let(:user) { create(:user) }

    context 'when invalid token included' do
      before { get '/users/me', as: :json }

      it 'responds with Unauthorized error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when valid token included' do
      before do
        configure_auth_cookie(user.id)
        get '/users/me'
      end

      it 'responds with success status' do
        expect(response).to have_http_status(:success)
      end

      it 'responds with user attributes' do
        expect(response.body).to eq UserSerializer.new(user).to_json
      end
    end
  end

  # UPDATE USER TESTS
  describe 'PUT /users' do
    let(:user) { create(:user) }

    context 'when invalid token included' do
      before { put '/users', as: :json }

      it 'responds with Unauthorized error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when valid token included' do
      before do
        configure_auth_cookie(user.id)
        put '/users', params: { user: }, as: :json
      end

      it 'responds with success status' do
        expect(response).to have_http_status(:success)
      end

      it 'responds with user attributes' do
        expect(response.body).to eq UserSerializer.new(user).to_json
      end
    end
  end

  # DELETE USERS TESTS
  describe 'DELETE /users' do
    let(:user) { create(:user) }

    context 'when invalid token included' do
      before { delete '/users', as: :json }

      it 'responds with Unauthorized error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when valid token included' do
      subject(:make_request) do
        delete '/users'
      end

      before { configure_auth_cookie(user.id) }

      it 'responds with success status' do
        make_request
        expect(response).to have_http_status(:success)
      end

      it 'destroys user from database' do
        expect { make_request }.to change(User, :count).by(-1)
      end

      it 'deletes auth cookie' do
        make_request
        expect(cookies[:auth_token]).to eq('')
      end
    end
  end

  # SIGN IN USER REQUEST
  describe 'POST /users/sign_in' do
    let(:user) { create(:user) }

    context 'when valid credentials provided' do
      before do
        post '/users/sign_in', params: { email: user.email, password: user.password }
      end

      it 'store aut_token in cookies' do
        expect(cookies[:auth_token]).not_to be_nil
      end

      it 'returns a 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid credentials provided' do
      before do
        post '/users/sign_in', params: { email: user.email, password: "bad_#{user.password}" }
      end

      it 'does not store aut_token in cookies' do
        expect(cookies[:auth_token]).to be_nil # TODO: handle invalid token still stored
      end

      it 'returns Unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

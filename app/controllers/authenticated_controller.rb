# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    auth_token = request.cookies[:auth_token]
    @current_user = AuthServices::RequestAuthenticator.call(auth_token)
  end
end

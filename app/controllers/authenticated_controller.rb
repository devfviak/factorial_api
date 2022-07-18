# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthServices::RequestAuthenticator.call(request.headers)
  end
end

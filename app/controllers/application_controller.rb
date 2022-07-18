# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler

  private

  def json_response(object, status = :ok)
    render json: object, status:
  end
end

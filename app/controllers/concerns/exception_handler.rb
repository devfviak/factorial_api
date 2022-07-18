# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  include Exceptions

  included do
    # ActiveRecord related
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ error: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ error: e.message }, :unprocessable_entity)
    end

    # Authentication related
    rescue_from InvalidToken, with: :unauthorized_response
    rescue_from ExpiredToken, with: :unauthorized_response
    rescue_from MissingToken, with: :unauthorized_response

    # Request Parameters related
    rescue_from ActionController::ParameterMissing do |e|
      json_response({ error: e.message }, :bad_request)
    end

    private

    def unauthorized_response(exception)
      json_response({ error: exception.message }, :unauthorized)
    end
  end
end

# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  include Exceptions

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from InvalidToken, with: :unauthorized_response

    private

    def unauthorized_response(exception)
      json_response({ message: exception.message }, :unauthorized)
    end
  end
end

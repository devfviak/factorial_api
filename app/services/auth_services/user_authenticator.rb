# frozen_string_literal: true

module AuthServices
  class UserAuthenticator < ApplicationService
    include Exceptions

    attr_reader :email, :password

    def initialize(email, password)
      super()
      @email = email.downcase
      @password = password
    end

    def call
      user = User.find_by(email:)
      raise InvalidCredentials unless user&.authenticate(password)

      JsonWebToken.encode({ user_id: user.id })
    end
  end
end

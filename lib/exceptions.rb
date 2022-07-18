module Exceptions
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end
  class ExpiredToken < StandardError; end
  class InvalidCredentials < StandardError; end
end

# frozen_string_literal: true

class User < ApplicationRecord
  include Auditable

  EMAIL_REGEXP = URI::MailTo::EMAIL_REGEXP
  PHONE_E164_REGEXP = Regexp.new('\A\+[1-9]\d{1,14}\z')

  has_secure_password
  has_many :expenses, dependent: :destroy

  validates :first_name, :last_name, :email, :phone, :password_digest, presence: true
  validates :first_name, :last_name, length: { in: 0..50 }

  validates :phone, format: { with: PHONE_E164_REGEXP },
                    uniqueness: { case_sensitive: false }

  validates :email, format: { with: EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false },
                    length: { in: 4..254 }

  def email=(email)
    super(email&.downcase)
  end
end

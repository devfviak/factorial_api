# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  email           :string(255)      not null
#  password_digest :text(65535)      not null
#  phone           :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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

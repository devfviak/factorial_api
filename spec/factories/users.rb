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
FactoryBot.define do
  factory :user do
    first_name { 'Pedro' }
    last_name { 'Avila' }
    email { 'pedro@avila.com' }
    password { 'password' }
    password_confirmation { 'password' }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end

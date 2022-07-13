# frozen_string_literal: true

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

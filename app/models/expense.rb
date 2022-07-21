# frozen_string_literal: true

# == Schema Information
#
# Table name: expenses
#
#  id             :bigint           not null, primary key
#  concept        :string(255)      not null
#  subtotal_cents :decimal(10, )    not null
#  total_cents    :decimal(10, )    not null
#  currency       :string(255)      not null
#  processor      :string(255)      not null
#  processor_info :json
#  user_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Expense < ApplicationRecord
  belongs_to :user
end

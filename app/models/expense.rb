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
  include Auditable

  belongs_to :user

  validates :concept, :subtotal_cents, :total_cents, :currency, :processor, presence: true
  validates :concept, length: { in: 0..50 }
end

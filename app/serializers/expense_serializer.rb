# frozen_string_literal: true

class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :concept, :total, :subtotal, :currency, :processor

  def total
    object.total_cents * 100
  end

  def subtotal
    object.subtotal_cents * 100
  end

  def timestamp
    object.created_at.to_s
  end
end

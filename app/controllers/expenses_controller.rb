# frozen_string_literal: true

class ExpensesController < AuthenticatedController
  # GET /expenses
  def index
    json_response(@current_user.expenses)
  end

  # GET /expenses/:id
  def show
    expense = @current_user.expenses.find(params[:id])
    json_response(expense)
  end
end

# frozen_string_literal: true

class ExpensesController < AuthenticatedController
  before_action :set_expense, only: %i[show audit_logs]

  # GET /users/expenses
  def index
    json_response(@current_user.expenses)
  end

  # GET /users/expenses/:id
  def show
    json_response(@expense)
  end

  # GET /users/expenses/:expense_id/audit_logs
  def audit_logs
    json_response(@expense.audit_logs)
  end

  private

  def set_expense
    @expense = Expense.find_by(user_id: @current_user.id, id: params[:expense_id])
  end
end

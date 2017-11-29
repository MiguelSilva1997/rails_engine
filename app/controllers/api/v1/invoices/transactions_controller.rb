class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    render json: Transaction.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:invoice_id)
  end
end

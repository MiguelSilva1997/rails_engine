class Api::V1::Transactions::InvoiceController < ApplicationController

  def index
    transaction = Transaction.find(transaction_params[:transaction_id].to_i)
    render json: Invoice.find(transaction.invoice_id)
  end

  private

  def transaction_params
    params.permit(:transaction_id)
  end
end

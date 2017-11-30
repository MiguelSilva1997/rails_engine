class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    invoice = Invoice.find(invoice_params[:invoice_id].to_i)
    render json: invoice.items
  end

  private

  def invoice_params
    params.permit(:invoice_id)
  end
end

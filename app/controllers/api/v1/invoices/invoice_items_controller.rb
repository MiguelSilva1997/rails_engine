class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:invoice_id)
  end
end

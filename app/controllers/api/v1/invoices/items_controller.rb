class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    render json: Item.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:invoice_id)
  end
end

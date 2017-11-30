class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItem.find_all(search_params)
  end

  def show
    render json: InvoiceItem.find_invoice_item(search_params)
  end

  private

  def search_params
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
end

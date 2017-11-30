class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    invoice_items = InvoiceItem.where(item_params)
    render json: invoice_items
  end

  private

  def item_params
    params.permit(:item_id)
  end
end

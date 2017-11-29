class Api::V1::InvoiceItems::ItemController < ApplicationController
  def index
    invoice_item = InvoiceItem.find(invoice_item_params[:invoice_item_id].to_i)
    item = Item.find(invoice_item.item_id)
    render json: item
  end

  private

  def invoice_item_params
    params.permit(:invoice_item_id)
  end
end

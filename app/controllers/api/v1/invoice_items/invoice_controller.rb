class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def index
   invoice_item = InvoiceItem.find(invoice_item_params[:invoice_item_id].to_i)
   invoice = Invoice.find(invoice_item.invoice_id)
   render json: invoice
 end

 private

 def invoice_item_params
   params.permit(:invoice_item_id)
 end

end

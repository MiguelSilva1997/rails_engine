class Api::V1::Invoices::CustomerController < ApplicationController

  def index
     invoice = Invoice.find(invoice_params[:invoice_id].to_i)
     render json: Customer.find(invoice.customer_id)
   end

   private

   def invoice_params
     params.permit(:invoice_id)
   end
end

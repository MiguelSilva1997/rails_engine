class Api::V1::Customers::TransactionsController < ApplicationController

  def index
     customer = Customer.find(customer_params[:customer_id].to_i)
     render json: Transaction.joins(invoice: [:customer]).where('invoices.customer_id =?', customer.id)
   end

   private

   def customer_params
     params.permit(:customer_id)
   end


end

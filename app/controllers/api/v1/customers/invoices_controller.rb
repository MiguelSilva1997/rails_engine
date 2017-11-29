class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    render json: Invoice.where(customer_params)
  end

  private

  def customer_params
    params.permit(:customer_id)
  end
end

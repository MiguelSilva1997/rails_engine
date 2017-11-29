class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    render json: Invoice.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:merchant_id)
  end
end

class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    merchants = Merchant.most_revenue(merchant_params[:quantity]) if params[:quantity]
    merchants = Merchant.most_revenue unless params[:quantity]
    render json: merchants
  end

  private

  def merchant_params
    params[:quantity] = params[:quantity].to_i
    params.permit(:quantity)
  end

end

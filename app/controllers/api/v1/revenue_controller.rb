class Api::V1::RevenueController < ApplicationController

  def index
    revenue = Merchant.revenue(merchant_params)
    render json: revenue, :serializer => RevenueSerializer
  end

  private

  def merchant_params
    if params[:date]
      params[:created_at] = params[:date]
      params.permit(:merchant_id, :created_at)
    else
      params.permit(:merchant_id)
    end
  end
end

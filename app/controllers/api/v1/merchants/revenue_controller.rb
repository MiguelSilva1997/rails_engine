class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    total_revenue = Merchant.revenue(merchant_params)
    render json: total_revenue, :serializer => TotalRevenueSerializer
  end

  private

  def merchant_params
      params[:created_at] = params[:date]
      params.permit(:created_at)
  end
end

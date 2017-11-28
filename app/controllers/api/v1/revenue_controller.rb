class Api::V1::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue
  end
end

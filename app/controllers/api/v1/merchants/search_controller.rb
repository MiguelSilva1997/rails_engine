class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: Merchant.find_all(params)
  end

  def show
    render json: Merchant.find_merchant(params)
  end
end

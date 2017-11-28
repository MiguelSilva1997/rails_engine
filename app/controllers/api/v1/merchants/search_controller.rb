class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: Merchant.find_all(search_params)
  end

  def show
    render json: Merchant.find_merchant(search_params)
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end

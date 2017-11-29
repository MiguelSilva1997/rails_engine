class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: Item.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:merchant_id)
  end
end

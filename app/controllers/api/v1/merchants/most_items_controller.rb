class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: Merchant.most_items(merchant_params['quantity'])
  end

  def merchant_params
    params.permit(:quantity)
  end

end

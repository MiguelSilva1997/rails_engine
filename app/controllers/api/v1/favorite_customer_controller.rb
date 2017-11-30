class Api::V1::FavoriteCustomerController < ApplicationController
  def index
    merchant = Merchant.favorite_customer(merchant_params)
    render json: merchant, :serializer => CustomerSerializer
  end

  def merchant_params
    params.permit(:merchant_id)
  end

end

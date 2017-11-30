class Api::V1::FavoriteMerchantController < ApplicationController
  def index
    merchant = Customer.favorite_merchant(customer_params)
    render json: merchant, :serializer => MerchantSerializer
  end

  def customer_params
    params.permit(:customer_id)
  end

end

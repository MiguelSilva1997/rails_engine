class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.find_random
  end

end

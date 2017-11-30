class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.most_items(item_params[:quantity])
  end

  private

  def item_params
    params.permit(:quantity)
  end
end

class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: Customer.find_all(search_params)
  end

  def show
    render json: Customer.find_customer(search_params)
  end

  private

  def search_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end

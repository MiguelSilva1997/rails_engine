class Api::V1::Transactions::SearchController < ApplicationController

  def index
    render json: Transaction.find_all(search_params)
  end

  def show
    render json: Transaction.find_transaction(search_params)
  end

  private

  def search_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at)
  end
end

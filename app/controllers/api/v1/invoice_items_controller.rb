class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItems.all
  end

  def show
    render json: InvoiceItems.find(params[:id])
  end

end

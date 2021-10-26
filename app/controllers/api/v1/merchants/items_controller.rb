class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    if params[:merchant_id] && Merchant.exists?(params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
      render json: ItemSerializer.new(items)
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end
end

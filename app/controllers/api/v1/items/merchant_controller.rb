class Api::V1::Items::MerchantController < ApplicationController

  def index
    if params[:item_id] && Item.exists?(params[:item_id])
      item = Item.find(params[:item_id])
      merchant = item.merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: { error: 'ERROR: Invalid Request' }, status: :not_found
    end
  end
end

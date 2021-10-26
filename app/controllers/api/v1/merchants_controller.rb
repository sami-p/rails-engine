class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.by_page(page = params[:page].to_i, per_page = params[:per_page].to_i)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    if params[:id] && Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      render(json: MerchantSerializer.new(merchant))
    else
      render json: { error: 'ERROR: Merchant Not Found.' }, status: :not_found
    end
  end
end

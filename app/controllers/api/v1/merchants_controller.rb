class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.by_page(page = params[:page].to_i, per_page = params[:per_page].to_i)
    render json: MerchantSerializer.new(merchants)
  end
end

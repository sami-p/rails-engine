class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if params[:quantity] && params[:quantity].to_i > 0
      merchants = Merchant.top_merchants_by_revenue(params[:quantity])
      render json: RevenueSerializer.new(merchants)
    else
      render json: { error: "ERROR: Invalid Request" }, status: 400
    end
  end
end

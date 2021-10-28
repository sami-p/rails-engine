class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.by_page(page = params[:page].to_i, per_page = params[:per_page].to_i)
    render json: ItemSerializer.new(items)
  end

  def show
    if params[:id] && Item.exists?(params[:id])
      item = Item.find(params[:id])
      render(json: ItemSerializer.new(item))
    else
      render json: { error: 'ERROR: Item Not Found.' }, status: :not_found
    end
  end

  def new
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      render json: { error: 'ERROR: Invalid Request.' }, status: :not_found
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end

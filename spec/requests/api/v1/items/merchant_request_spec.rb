require 'rails_helper'

RSpec.describe "Items Merchant API" do
  it 'finds an items merchant' do
    merchant = create(:merchant)

    create_list(:item, 5, merchant_id: merchant.id)

    expect(Item.count).to eq(5)

    item = Item.last

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end

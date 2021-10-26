require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  it 'retrieves all items for a single merchant' do
    merchant = create(:merchant)

    create_list(:item, 30, merchant_id: merchant.id)

    get api_v1_merchant_items_path(merchant.id)

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful
    expect(items.count).to eq(30)
  end
end

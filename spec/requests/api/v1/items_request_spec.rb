require 'rails_helper'

describe "Items API" do
  it "retrieves a list of all items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "retrieves one item by ID" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item).to have_key(:id)
    expect(item[:id].to_i).to eq(id)
    expect(item[:id]).to be_a(String)
    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it "creates (and deletes) an item" do
    merchant = create(:merchant)

    item_params = ({name: 'Swim Shady',
                    description: 'JJs fish, may he rest in peace.',
                    unit_price: 599.99,
                    merchant_id: merchant.id})

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "updates an existing item" do
    merchant = create(:merchant)

    id = create(:item).id

    previous_name = Item.last.name
    item_params = { name: "Ron Burgundy Poster" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Ron Burgundy Poster")
  end

  it "finds all items by name" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = Item.create!({name: "Cozy Mug",
                           description: "A mug for cozy warm drinks.",
                           unit_price: 12.99,
                           merchant_id: merchant_1.id})

    item_2 = Item.create!({name: "Cozy Rug",
                           description: "A rug for cozy times.",
                           unit_price: 10.99,
                           merchant_id: merchant_2.id})

    item_3 = Item.create!({name: "Cozy Pug",
                           description: "A Pug that is really cozy.",
                           unit_price: 17.99,
                           merchant_id: merchant_3.id})

    item_4 = Item.create!({name: "Rice",
                           description: "That's it. Just rice.",
                           unit_price: 4.99,
                           merchant_id: merchant_3.id})

     get "/api/v1/items/find_all?name=cozy"

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(items.count).to eq(3)
     expect(items.first[:attributes][:name]).to eq(item_1.name)
     expect(items.last[:attributes][:name]).to eq(item_2.name)
  end
end

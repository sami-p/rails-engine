require 'rails_helper'

describe "Merchants API" do
  describe "RESTful routes"
    it "retrieves a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchants.count).to eq(3)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'retrieves one merchant by ID' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to eq(id)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

  describe 'NON RESTful routes' do
    it 'finds one merchant by search criteria' do
      merchant_1 = Merchant.create!(name: 'Duke')
      merchant_2 = Merchant.create!(name: 'Hank')
      merchant_3 = Merchant.create!(name: 'Walter')
      merchant_4 = Merchant.create!(name: 'Earl')

      get '/api/v1/merchants/find?name=duke'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)[:data]
      merchant_result = body

      expect(merchant_result[:type]).to eq("merchant")
      expect(merchant_result[:attributes][:name]).to eq(merchant_1.name)
      expect(merchant_result).to have_key(:id)
      expect(merchant_result[:id].to_i).to eq(merchant_1.id)
    end
  end
end

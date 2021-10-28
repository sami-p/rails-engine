require 'rails_helper'

RSpec.describe 'Revenue Merchants API' do
  it 'finds top merchants by revenue' do
    merchant_1 = create(:merchant, name: "Khoi")
    customer_1 = create(:customer, first_name: "Dane", last_name: "Brophy")

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_1)

    invoice_item_1 = create(:invoice_item, invoice: invoice_1, quantity: 1)
    invoice_item_2 = create(:invoice_item, invoice: invoice_1, quantity: 2)

    merchant_2 = create(:merchant, name: "Kelsy")
    customer_2 = create(:customer, first_name: "Henry", last_name: "Schmid")

    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

    transaction_3 = create(:transaction, invoice: invoice_2)
    transaction_4 = create(:transaction, invoice: invoice_2)
    transaction_5 = create(:transaction, invoice: invoice_2)

    invoice_item_3 = create(:invoice_item, invoice: invoice_2, quantity: 2)
    invoice_item_4 = create(:invoice_item, invoice: invoice_2, quantity: 2)
    invoice_item_5 = create(:invoice_item, invoice: invoice_2, quantity: 2)


    merchant_3 = create(:merchant, name: "Jamie")
    customer_3 = create(:customer, first_name: "JJ", last_name: "Jones")

    invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_3.id)

    transaction_6 = create(:transaction, invoice: invoice_3)
    transaction_7 = create(:transaction, invoice: invoice_3)
    transaction_8 = create(:transaction, invoice: invoice_3)

    invoice_item_6 = create(:invoice_item, invoice: invoice_3, quantity: 3)
    invoice_item_7 = create(:invoice_item, invoice: invoice_3, quantity: 3)
    invoice_item_8 = create(:invoice_item, invoice: invoice_3, quantity: 10)

    get "/api/v1/revenue/merchants?quantity=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

		expect(merchants.first[:attributes][:name]).to eq(merchant_3.name)
    expect(merchants.last[:attributes][:name]).to eq(merchant_2.name)
  end
end

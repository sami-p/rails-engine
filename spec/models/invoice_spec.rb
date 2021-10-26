require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Associations' do
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end
end

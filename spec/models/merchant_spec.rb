require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Associations' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:invoices) }
  end
end

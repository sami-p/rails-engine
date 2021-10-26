require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'Associations' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Associations' do
    it { should have_many(:invoices) }
  end
end

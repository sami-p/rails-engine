require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Associations' do
    it { should belong_to(:invoice) }
  end
end

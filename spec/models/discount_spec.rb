require 'rails_helper'

RSpec.describe Discount do
  describe 'Relationships' do
    it {should belong_to :merchant}
  end

  describe 'Validations' do
    it {should validate_numericality_of(:percentage)
          .is_less_than(100)
          .is_greater_than(0)
          .only_integer}
    it {should validate_numericality_of(:items_required)
          .only_integer}
  end

  describe 'class methods' do
    it '.by_percentage' do
      cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
      discount_1 = Discount.create!(percentage: 30, items_required: 10, merchant_id: cory.id)
      discount_2 = Discount.create!(percentage: 20, items_required: 10, merchant_id: cory.id)
      discount_3 = Discount.create!(percentage: 50, items_required: 10, merchant_id: cory.id)

      expect(Discount.all.by_percentage).to eq([discount_3, discount_1, discount_2])
    end
  end
end

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
end

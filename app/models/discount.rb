class Discount < ApplicationRecord
  validates_numericality_of :percentage,
                            only_integer: true,
                            greater_than: 0,
                            less_than: 100

  validates_numericality_of :items_required,
                            only_integer: true

  belongs_to :merchant
end

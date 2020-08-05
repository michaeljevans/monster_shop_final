class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def self.active_items
    where(active: true)
  end

  def self.by_popularity(limit = nil, order = "DESC")
    left_joins(:order_items)
    .select('items.id, items.name, COALESCE(sum(order_items.quantity), 0) AS total_sold')
    .group(:id)
    .order("total_sold #{order}")
    .limit(limit)
  end

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def quantity_required_for_discount
    return merchant.discounts.order(:items_required).first.items_required if !merchant.discounts.empty?
    Float::INFINITY
  end

  def find_best_discount(cart_amount)
    discount_savings = {}
    eligible_discounts(cart_amount).each do |discount|
      discount_savings[discount.id] = cart_amount * self.price * (1 - discount.percentage.to_f / 100)
    end
    discount_id = discount_savings.min_by { |_, value| value }.first
    Discount.find(discount_id)
  end

  def eligible_discounts(item_count)
    merchant.discounts.where('discounts.items_required <= ?', item_count)
  end
end

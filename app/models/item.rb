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

  def find_best_discount(item_count)
    merchant.discounts
      .order('discounts.percentage * discounts.items_required DESC')
      .where('discounts.items_required <= ?', item_count)
      .first
  end
end

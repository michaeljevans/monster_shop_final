class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      if quantity >= Item.find(item_id).quantity_required_for_discount
        grand_total += discounted_subtotal_for(item_id)
      else
        grand_total += subtotal_for(item_id)
      end
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_for(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def discounted_subtotal_for(item_id)
    item = Item.find(item_id)
    discount = item.find_best_discount(count_of(item_id))
    @contents[item_id.to_s] * item.price * (1 - discount.percentage.to_f / 100) unless discount.nil?
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end

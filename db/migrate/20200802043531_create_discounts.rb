class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.integer :percentage
      t.integer :items_required
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end

class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.references :order_items, foreign_key: true
      t.decimal :amount, default: 0
      t.decimal :threshold, default: 0

      t.timestamps
    end
  end
end

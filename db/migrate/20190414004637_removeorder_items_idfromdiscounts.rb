class RemoveorderItemsIdfromdiscounts < ActiveRecord::Migration[5.1]
  def change
    remove_reference :discounts, :order_items, foreign_key: true
  end
end

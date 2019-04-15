require 'rails_helper'

RSpec.describe "As a merchant, when I visit my dashboard," do
  before :each do
    @merchant = create(:merchant)
    @merchant_1 = create(:merchant)

    login_as(@merchant)

    @item_1, @item_2 = create_list(:item, 2, user: @merchant)
    @item_3 = create(:inactive_item, user: @merchant)
    @item_4 = create(:item, user: @merchant_1)

    @order_1, @order_2 = create_list(:order, 2)
    @order_3 = create(:shipped_order)
    @order_4 = create(:cancelled_order)
    @order_5 = create(:order)

    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, quantity: 4, price: 60)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, quantity: 2, price: 10)
    @order_item_3 = create(:order_item, order: @order_2, item: @item_2, quantity: 1, price: 10)
    @order_item_4 = create(:order_item, order: @order_3, item: @item_1, quantity: 4, price: 2)

    @order_item_5 = create(:order_item, order: @order_5, item: @item_4, quantity: 5, price: 50)
  end

  it "I can see a link to discounts offered by me" do
    visit dashboard_path

    find_link('Promotional Offers').visible?
  end

  it "I click on Items for Sale link, I see a button to add promotional offer for each item" do
    visit dashboard_items_path

    within "#item-#{@item_1.id}" do
      expect(page).to have_link(item.name)
      expect(page).to have_content("Sold by: #{item.user.name}")
      expect(page).to have_content("In stock: #{item.inventory}")
      expect(page).to have_content(number_to_currency(item.price))
      expect(page.find("#dashboard-items-#{@item_1.id}-image")['src']).to have_content(item.image)
      find_button("Add New Discount")
    end

    within "#item-#{@item_2.id}" do
      expect(page).to have_link(item.name)
      expect(page).to have_content("Sold by: #{item.user.name}")
      expect(page).to have_content("In stock: #{item.inventory}")
      expect(page).to have_content(number_to_currency(item.price))
      expect(page.find("#dashboard-items-#{@item_2.id}-image")['src']).to have_content(item.image)
      find_button("Add New Discount")
    end

    expect(page).to_not have_content(@item_3.id)
  end
end

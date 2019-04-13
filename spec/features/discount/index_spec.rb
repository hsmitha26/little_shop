require 'rails_helper'

RSpec.describe "As a merchant, when I visit my dashboard," do
  before :each do
    @merchant = create(:merchant)
    login_as(@merchant)
  end

  it "I can see a link to discounts offered by me" do
    visit dashboard_path

    find_link('Discounts').visible?
  end

  it "I click on Discounts link, I go to the page with all my discounted items" do
    visit dashboard_path

    click_on "Discounts"
    expect(current_path).to eq(dashboard_discounts_path)
  end
end

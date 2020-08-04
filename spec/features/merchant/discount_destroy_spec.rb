require 'rails_helper'

RSpec.describe 'Merchant discount index' do
  it 'has a button that allows the merchant to delete a discount' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)
    discount = Discount.create!(percentage: 10, items_required: 20, merchant_id: cory.id)
    discount = Discount.create!(percentage: 5, items_required: 10, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    expect(page).to have_content("Percentage: 10%")
    expect(page).to have_content("Items Required: 20")
    expect(page).to have_content("Percentage: 5%")
    expect(page).to have_content("Items Required: 10")

    within ".discount-#{discount.id}" do
      click_button 'Delete Discount'
    end

    expect(current_path).to eq('/merchant/discounts')

    expect(page).to have_content('Discount has been deleted.')
    expect(page).to have_content("Percentage: 10%")
    expect(page).to have_content("Items Required: 20")
    expect(page).to_not have_content("Percentage: 5%")
    expect(page).to_not have_content("Items Required: 10")
  end
end

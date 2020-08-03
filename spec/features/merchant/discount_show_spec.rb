require 'rails_helper'

RSpec.describe 'Merchant discount show page' do
  it 'displays relevant information about the discount' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)
    discount = Discount.create!(percentage: 10, items_required: 10, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    within ".discount-#{discount.id}" do
      click_link "#{discount.id}"
    end

    expect(current_path).to eq("/merchant/discounts/#{discount.id}")

    expect(page).to have_content("Discount # #{discount.id}")
    expect(page).to have_content("Percentage Discount: #{discount.percentage}%")
    expect(page).to have_content("Items Required for Discount: #{discount.items_required}")
  end
end

require 'rails_helper'

RSpec.describe 'Merchant discounts index' do
  it 'allows the merchant user to create new discounts' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    click_button 'Add New Promotional Discount'

    expect(current_path).to eq('/merchant/discounts/new')

    fill_in 'Percentage', with: 5
    fill_in 'Items Required', with: 10
    click_button 'Create Discount'

    expect(current_path).to eq('/merchant/discounts')

    expect(page).to have_content('Discount created!')
    expect(page).to have_content('Percentage: 5%')
    expect(page).to have_content('Items Required: 10')
  end
end

require 'rails_helper'

RSpec.describe 'Merchant discount index' do
  it 'displays all discounts created by the merchant' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    brian = Merchant.create!(name: "Brian's Bazaar", address: '789 South St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)
    brian_merch = User.create!(name: 'Brian', address: '789 Beeswax, Not Yours Blvd', city: 'Denver', state: 'CO', zip: 12345, email: 'brian@me.com', password: 'bazaar', role: 1, merchant_id: brian.id)
    discount = Discount.create!(percentage: 10, items_required: 10, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    expect(current_path).to eq('/merchant')

    expect(page).to have_content('View Current Discounts')
    click_on 'View Current Discounts'

    expect(current_path).to eq('/merchant/discounts')

    within ".discount-#{discount.id}" do
      expect(page).to have_content("Discount # #{discount.id}")
      expect(page).to have_link(discount.id)
      expect(page).to have_content("Percentage: #{discount.percentage}%")
      expect(page).to have_content("Items Required: #{discount.items_required}")
    end

    visit '/logout'

    visit '/login'
    fill_in :email, with: brian_merch.email
    fill_in :password, with: brian_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    expect(page).to_not have_content('Percentage:')
    expect(page).to_not have_content('Items Required:')
  end
end

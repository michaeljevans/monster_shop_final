require 'rails_helper'

RSpec.describe 'Merchant discount index' do
  it 'has a button that allows the merchant to edit/update discount attributes' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)
    discount = Discount.create!(percentage: 10, items_required: 10, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    within ".discount-#{discount.id}" do
      click_button 'Edit Discount'
    end

    expect(current_path).to eq("/merchant/discounts/#{discount.id}/edit")

    fill_in 'Items Required', with: 20
    click_button 'Update Discount'

    expect(current_path).to eq("/merchant/discounts/#{discount.id}")

    expect(page).to have_content('Items Required for Discount: 20')
    expect(page).to_not have_content('Items Required for Discount: 10')
  end

  it 'displays an error for incomplete discount information' do
    cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
    cory_merch = User.create!(name: 'Cory', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'cory@me.com', password: 'coffee', role: 1, merchant_id: cory.id)
    discount = Discount.create!(percentage: 10, items_required: 10, merchant_id: cory.id)

    visit '/login'
    fill_in :email, with: cory_merch.email
    fill_in :password, with: cory_merch.password
    click_button 'Log In'

    click_on 'View Current Discounts'

    within ".discount-#{discount.id}" do
      click_button 'Edit Discount'
    end

    fill_in 'Percentage', with: ''
    fill_in 'Items Required', with: 20
    click_button 'Update Discount'

    expect(page).to have_content('All fields are required to update discount information.')
  end
end

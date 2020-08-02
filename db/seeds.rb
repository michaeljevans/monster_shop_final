# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchants
meg   = Merchant.create!(name: "Meg's Market", address: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
brian = Merchant.create!(name: "Brian's Bazaar", address: '789 South St', city: 'Denver', state: 'CO', zip: 12345)

# Users
admin       = User.create!(name: 'Admin', address: '123 Nunya Business Blvd', city: 'Denver', state: 'CO', zip: 12345, email: 'admin@me.com', password: 'supersecret', role: 2)
cory_merch  = User.create!(name: 'Meg', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'meg@me.com', password: 'market', role: 1, merchant_id: cory.id)
brian_merch = User.create!(name: 'Brian', address: '789 Beeswax, Not Yours Blvd', city: 'Denver', state: 'CO', zip: 12345, email: 'brian@me.com', password: 'bazaar', role: 1, merchant_id: brian.id)

# Meg's Items
meh = Item.create!(name: 'Light Roast', description: 'Smooth', price: 15, inventory: 20, image: 'https://kitchentoolsmaster.com/wp-content/uploads/2020/02/light-roast-vs-dark-roast-coffee-1024x768.jpg', merchant_id: meg.id)

# Cory's Items
light_roast = Item.create!(name: 'Light Roast', description: 'Smooth', price: 15, inventory: 20, image: 'https://kitchentoolsmaster.com/wp-content/uploads/2020/02/light-roast-vs-dark-roast-coffee-1024x768.jpg', merchant_id: cory.id)
dark_roast  = Item.create!(name: 'Dark Roast', description: 'Bold', price: 15, inventory: 20, image: 'https://www.holybeanscafe.com/holybeanscafe/wp-content/uploads/2015/11/dark-roast-coffee.jpg', merchant_id: cory.id)
mug         = Item.create!(name: 'Coffee Mug', description: 'For Coffee', price: 10, inventory: 10, image: 'https://assets.katomcdn.com/q_auto,f_auto/products/634/634-5201/634-5201.jpg', merchant_id: cory.id)

# Brian's Items
blah = Item.create!(name: 'Light Roast', description: 'Smooth', price: 15, inventory: 20, image: 'https://kitchentoolsmaster.com/wp-content/uploads/2020/02/light-roast-vs-dark-roast-coffee-1024x768.jpg', merchant_id: brian.id)

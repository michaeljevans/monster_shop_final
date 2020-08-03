# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OrderItem.destroy_all
Review.destroy_all
Item.destroy_all
Discount.destroy_all
Order.destroy_all
Merchant.destroy_all
User.destroy_all

# Merchants
meg   = Merchant.create!(name: "Meg's Market", address: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
cory  = Merchant.create!(name: "Cory's Coffee", address: '456 North St', city: 'Denver', state: 'CO', zip: 12345)
brian = Merchant.create!(name: "Brian's Bazaar", address: '789 South St', city: 'Denver', state: 'CO', zip: 12345)

# Users
admin       = User.create!(name: 'Admin', address: '123 Nunya Business Blvd', city: 'Denver', state: 'CO', zip: 12345, email: 'admin@me.com', password: 'supersecret', role: 2)
cory_merch  = User.create!(name: 'Meg', address: "456 Don't Worry About It Dr", city: 'Denver', state: 'CO', zip: 12345, email: 'meg@me.com', password: 'market', role: 1, merchant_id: cory.id)
brian_merch = User.create!(name: 'Brian', address: '789 Beeswax, Not Yours Blvd', city: 'Denver', state: 'CO', zip: 12345, email: 'brian@me.com', password: 'bazaar', role: 1, merchant_id: brian.id)

# Meg's Items
pull_toy = Item.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 23, merchant_id: meg.id)
dog_bone = Item.create!(name: "Dog Bone", description: "They'll love it!", price: 9, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21, merchant_id: meg.id)
kong     = Item.create!(name: "Kong", description: "Distract your dog for a while!", price: 12, image: "https://images-na.ssl-images-amazon.com/images/I/719dcnCnHfL._AC_SL1500_.jpg", inventory: 15, merchant_id: meg.id)
bed      = Item.create!(name: "Dog Bed", description: "Sleepy time!", price: 40, image: "https://images-na.ssl-images-amazon.com/images/I/71IvYiQYcAL._AC_SY450_.jpg", inventory: 12, merchant_id: meg.id)

# Cory's Items
light_roast = Item.create!(name: 'Light Roast', description: 'Smooth & Savory', price: 15, inventory: 20, image: 'https://kitchentoolsmaster.com/wp-content/uploads/2020/02/light-roast-vs-dark-roast-coffee-1024x768.jpg', merchant_id: cory.id)
dark_roast  = Item.create!(name: 'Dark Roast', description: 'Bold & ', price: 15, inventory: 20, image: 'https://www.holybeanscafe.com/holybeanscafe/wp-content/uploads/2015/11/dark-roast-coffee.jpg', merchant_id: cory.id)
mug         = Item.create!(name: 'Coffee Mug', description: 'For Coffee', price: 10, inventory: 10, image: 'https://assets.katomcdn.com/q_auto,f_auto/products/634/634-5201/634-5201.jpg', merchant_id: cory.id)

# Brian's Items
tire  = Item.create!(name: "Road Tires", description: "They'll never pop!", price: 95, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
pump  = Item.create!(name: "Bike Pump", description: "Flat is bad!", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/615GENPCD5L._AC_SX425_.jpg", inventory: 15)
chain = Item.create!(name: "Bike Chain", description: "Replacement chain!", price: 35, image: "https://images-na.ssl-images-amazon.com/images/I/51cafKW0NgL._AC_.jpg", inventory: 75)
tool  = Item.create!(name: "Bike Tool", description: "All-In-One Tool", price: 20, image: "https://www.rei.com/media/product/718804", inventory: 20)

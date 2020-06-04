# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
User.destroy_all
Item.destroy_all
Order.destroy_all
ItemOrder.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
shop2 = Merchant.create(name: "Circle K", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, status: 1)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
helmet = bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)
pencil = bike_shop.items.create(name: "Yellow Pencil", description: "You can write with it!", price: 2, image: "https://images-na.jpg", inventory: 100)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#kpop shop items
cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)
album = shop.items.create(name: "Super Junior Time Slip", description: "Comeback CD", price: 55, image: "https://images-na.jpg", inventory: 120)
ahgabong = shop.items.create(name: "GOT7 Ahgabong", description: "True Ahgases Only", price: 100, image: "https://i.pinimg.com/originals/6d/50/3a/6d503a45a9a87f51241b12a9b4913234.jpg", inventory: 70)
dolls = shop.items.create(name: "All Day6 Member Dolls", description: "Time of your life", price: 600, image: "https://pm1.narvii.com/7023/c6f5e1b50b807ac9e991104ebcd8c0d6d0be24d7r1-628-548v2_uhq.jpg", inventory: 12)

default_user = User.create(name: "Default user",
                                       address: "55 Regular Person Lane",
                                       city: "Boulder",
                                       state: "Colorado",
                                       zip: "80209",
                                       email: "default_email@gmail.com",
                                       password: "default_password",
                                       role: 0)

employee = bike_shop.users.create!(name: "Employee user",
                                   address: "99 Working Hard Lane",
                                   city: "Los Angeles",
                                   state: "California",
                                   zip: "90210",
                                   email: "employee_email@gmail.com",
                                   password: "employee_password",
                                   role: 1)

admin = User.create(name: "Admin user",
                                       address: "123 Boss Rd",
                                       city: "Denver",
                                       state: "Colorado",
                                       zip: "81111",
                                       email: "admin_email@gmail.com",
                                       password: "admin_password",
                                       role: 2)
admin2 = User.create(name: "Rostam",
                                       address: "123 Boss Rd",
                                       city: "Denver",
                                       state: "Colorado",
                                       zip: "81111",
                                       email: "Rostammahabadi@gmail.com",
                                       password: "asdf",
                                       role: 2)

user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
order1 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, created_at: "May 30, 2020 18:54", status: 1)
order2 = Order.create(name: 'Hyram', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, status: 0)

ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 2, order_id: order1.id)
ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 3, order_id: order2.id)
ItemOrder.create!(item: tire, price: tire.price, quantity: 2, status: 1, order_id: order1.id)
ItemOrder.create!(item: pull_toy, price: pull_toy.price, quantity: 3, status: 1, order_id: order1.id)
ItemOrder.create!(item: dog_bone, price: dog_bone.price, quantity: 2, status: 1, order_id: order1.id)
ItemOrder.create!(item: pull_toy, price: pull_toy.price, quantity: 2, status: 1, order_id: order2.id)
ItemOrder.create!(item: tire, price: tire.price, quantity: 2, status: 1, order_id: order2.id)
ItemOrder.create!(item: dog_bone, price: dog_bone.price, quantity: 5, status: 1, order_id: order2.id)
ItemOrder.create!(item: ahgabong, price: ahgabong.price, quantity: 7, status: 1, order_id: order2.id)
ItemOrder.create!(item: album, price: album.price, quantity: 10, status: 1, order_id: order2.id)
ItemOrder.create!(item: dolls, price: dolls.price, quantity: 2, status: 1, order_id: order2.id)

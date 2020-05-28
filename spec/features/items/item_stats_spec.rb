require "rails_helper"

RSpec.describe "Items Index Stats Section" do
  it "can display the top 5 most and least popular items" do

    shop1 = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    shop2 = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    #Shop 2 items
    cardboard = shop2.items.create(name: "EXO Kai' Cardboard", description: "Just a cutout, not the real deal!", price: 10000, image: "https://images-na.jpg", inventory: 20)
    album = shop2.items.create(name: "Super Junior Time Slip", description: "Comeback CD", price: 55, image: "https://images-na.jpg", inventory: 120)
    ahgabong = shop2.items.create(name: "GOT7 Ahgabong", description: "True Ahgases Only", price: 100, image: "https://images-na.jpg", inventory: 70)
    dolls = shop2.items.create(name: "All Day6 Member Dolls", description: "Time of your life", price: 600, image: "https://images-na.jpg", inventory: 12)

    #Shop 1 items
    paper = shop1.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://images-na.jpg", inventory: 13)
    pencil = shop1.items.create(name: "Yellow Pencil", description: "You can write with it!", price: 2, image: "https://images-na.jpg", inventory: 100)
    journal = shop1.items.create(name: "Bullet Journal", description: "DIY Planner", price: 2, image: "https://images-na.jpg", inventory: 200)
    fan = shop1.items.create(name: "Personal Fan", description: "Cool Down Whenever", price: 35, image: "https://images-na.jpg", inventory: 100)

    user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow",role: 0)

    order_1 = Order.create(name: 'Hyram', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

    item_order1 = ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order_1.id)
    item_order2 = ItemOrder.create(item: ahgabong, price: ahgabong.price, quantity: 30, order_id: order_1.id)
    item_order3 = ItemOrder.create(item: album, price: album.price, quantity: 80, order_id: order_1.id)
    item_order4 = ItemOrder.create(item: ahgabong, price: ahgabong.price, quantity: 25, order_id: order_1.id)
    item_order5 = ItemOrder.create(item: journal, price: journal.price, quantity: 70, order_id: order_1.id)
    item_order6 = ItemOrder.create(item: dolls, price: dolls.price, quantity: 10, order_id: order_1.id)
    item_order7 = ItemOrder.create(item: fan, price: fan.price, quantity: 1, order_id: order_1.id)
    item_order8 = ItemOrder.create(item: paper, price: paper.price, quantity: 2, order_id: order_1.id)

    visit "/items"

    within "#most-popular" do
      expect(album.name).to appear_before(journal.name)
      expect(journal.name).to appear_before(ahgabong.name)
      expect(ahgabong.name).to appear_before(cardboard.name)
      expect(cardboard.name).to appear_before(dolls.name)
      expect(page).to_not have_content(fan.name)
    end

    within "#least-popular" do
      expect(pencil.name).to appear_before(fan.name)
      expect(fan.name).to appear_before(paper.name)
      expect(paper.name).to appear_before(dolls.name)
      expect(dolls.name).to appear_before(cardboard.name)
      expect(page).to_not have_content(album.name)
    end
  end
end

# User Story 18, Items Index Page Statistics
#
# As any kind of user on the system
# When I visit the items index page ("/items")
# I see an area with statistics:
# - the top 5 most popular items by quantity purchased, plus the quantity bought
# - the bottom 5 least popular items, plus the quantity bought
#
# "Popularity" is determined by total quantity of that item ordered

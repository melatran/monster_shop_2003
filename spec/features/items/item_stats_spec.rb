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
    paper = shop1.items.create(name: "Lined Paper", price: 20)
    pencil = shop1.items.create(name: "Yellow Pencil", description: "You can write with it!", price: 2, image: "https://images-na.jpg", inventory: 100)
    journal = shop1.items.create(name: "Bullet Journal", description: "DIY Planner", price: 2, image: "https://images-na.jpg", inventory: 200)
    fan = shop1.items.create(name: "Personal Fan", description: "Cool Down Whenever", price: 35, image: "https://images-na.jpg", inventory: 100)

    user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow",role: 0)

    order_1 = Order.create(name: 'Hyram', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

    ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order_1.id)
    ItemOrder.create(item: ahgabong, price: ahgabong.price, quantity: 55, order_id: order_1.id)
    ItemOrder.create(item: album, price: album.price, quantity: 80, order_id: order_1.id)
    ItemOrder.create(item: journal, price: journal.price, quantity: 70, order_id: order_1.id)
    ItemOrder.create(item: dolls, price: dolls.price, quantity: 10, order_id: order_1.id)
    ItemOrder.create(item: fan, price: fan.price, quantity: 2, order_id: order_1.id)
    ItemOrder.create(item: paper, price: paper.price, quantity: 3, order_id: order_1.id)
    ItemOrder.create(item: pencil, price: pencil.price, quantity: 1, order_id: order_1.id)

    visit "/items"

    save_and_open_page
    within "#most-popular" do
      expect(album.name).to appear_before(journal.name)
      expect(journal.name).to appear_before(ahgabong.name)
      expect(ahgabong.name).to appear_before(cardboard.name)
      expect(cardboard.name).to appear_before(dolls.name)
      expect(page).to_not have_content(fan.name)

      expect(page).to have_content("Super Junior Time Slip : 80 sold")
    end

    within "#least-popular" do
      expect(pencil.name).to appear_before(fan.name)
      expect(fan.name).to appear_before(dolls.name)
      expect(dolls.name).to appear_before(cardboard.name)
      expect(cardboard.name).to appear_before(ahgabong.name)
      expect(page).to_not have_content(album.name)
      expect(page).to have_content("Yellow Pencil : 1 sold")
    end
  end
end

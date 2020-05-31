require 'rails_helper'

RSpec.describe "Admin can see all orders" do
  it "shows all orders in the system" do

    shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)

    user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    order1 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, created_at: "May 30, 2020 18:54", status: 1)
    order2 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, status: 0)

    ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 2, order_id: order1.id)
    ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 3, order_id: order2.id)

    visit "/admin"

    expect(page).to have_content("#{order1.name}")
    expect(page).to have_content("#{order1.id}")
    expect(page).to have_content("#{order1.created_at}")
    expect(page).to have_content("#{order2.name}")
    expect(page).to have_content("#{order2.id}")
    expect(page).to have_content("#{order2.created_at}")

    expect("#{order2.name}").to appear_before("#{order1.name}")
    expect("#{order2.id}").to appear_before("#{order1.id}")
    expect("#{order2.created_at}").to appear_before("#{order1.created_at}")


  end

end

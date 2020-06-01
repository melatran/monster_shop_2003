require "rails_helper"

RSpec.describe "Cancelling An Order" do
  before :each do
    @shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @cardboard = @shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)

    @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    ItemOrder.create(item: @cardboard, price: @cardboard.price, quantity: 2, order_id: @order.id)
  end

  it "I can cancel an order and it will update the statuses of my order and item orders" do

    visit "/default_user/profile/orders/#{@order.id}"

    expect(page).to have_content("Status: Pending")

    click_link "Cancel Order"

    expect(page).to have_content("Your Order Has Been Cancelled")
    expect(current_path).to eq(default_user_profile_path)

    visit "/default_user/profile/orders/#{@order.id}"

    expect(page).to have_content("unfulfilled")
    expect(page).to have_content("Status: Cancelled")

    visit default_user_profile_orders_path

    expect(page).to have_content("Status: Cancelled")
  end

  it "can update inventory when order is cancelled" do

    visit "/default_user/profile/orders/#{@order.id}"

    expect(@shop.items.first.inventory).to eq(20)

    click_link "Cancel Order"

    expect(@shop.items.first.inventory).to eq(22)
  end
end

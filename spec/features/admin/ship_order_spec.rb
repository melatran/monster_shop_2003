require 'rails_helper'

RSpec.describe "Admin can ship an order" do
    before(:each) do
    @shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @cardboard = @shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 2)
    @default_user = User.create(name: "Rostam", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "asdf@gmail.com", password: "awesome", role: 0)

    @order1 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, created_at: "May 30, 2020 18:54", status: 1)
    @order2 = Order.create(name: 'Rostam', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id, status: 0)

    ItemOrder.create(item: @cardboard, price: @cardboard.price, quantity: 2, order_id: @order1.id)
    ItemOrder.create(item: @cardboard, price: @cardboard.price, quantity: 3, order_id: @order2.id)
    create1 = @order1.created_at.to_formatted_s(:long)
    create2 = @order2.created_at.to_formatted_s(:long)
    end

  # it "The user places the order" do
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)
  #   visit "/items/#{@paper.id}"
  #   click_on "Add To Cart"
  #   visit "/items/#{@paper.id}"
  #   click_on "Add To Cart"
  #   visit "/items/#{@tire.id}"
  #   click_on "Add To Cart"
  #   visit "/items/#{@pencil.id}"
  #   click_on "Add To Cart"
  #
  #   visit "/cart"
  #   click_on "Checkout"
  #
  #   name = "Bert"
  #   address = "123 Sesame St."
  #   city = "NYC"
  #   state = "New York"
  #   zip = 10001
  #
  #   fill_in :name, with: name
  #   fill_in :address, with: address
  #   fill_in :city, with: city
  #   fill_in :state, with: state
  #   fill_in :zip, with: zip
  #
  #   click_button "Create Order"
  # end

  it "will show the admin a button to ship the order" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit "/admin/dashboard"

    within ".orders-#{@order1.id}" do
      page.should have_no_content("Ship")
    end

    within ".orders-#{@order2.id}" do
      has_link? "Ship"
      click_on "Ship"
    end

    expect(current_path).to eq("/admin/dashboard")

  end

  it "The user can no longer cancel the order" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@default_user)

    visit default_user_profile_orders_path

    expect(page).to_not have_content("Cancel")

  end
end

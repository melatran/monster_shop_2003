require 'rails_helper'

RSpec.describe "When i visit my profile page" do
  it "shows all of my profile data on the page except password and a link to edit my profile data" do

    default_user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow",
      role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit default_user_profile_path

      has_link?("Edit Profile")
      click_link("Edit Profile")

      expect(current_path).to eq(default_user_profile_edit_path)
  end

  it "shows a link to My Orders when I have placed orders" do

    shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 10000, image: "https://images-na.jpg", inventory: 20)

    order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order.id)

    default_user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

    visit default_user_profile_path

    click_on "My Orders"

    expect(current_path).to eq("/default_user/profile/orders")
  end
end

# User Story 27, User Profile displays Orders link
#
# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"

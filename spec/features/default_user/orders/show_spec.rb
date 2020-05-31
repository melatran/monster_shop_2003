require "rails_helper"

RSpec.describe "Order Show Page" do
  describe "When I click on an order number from my order index" do
    it "can take me to an order show page and display the order's informaton" do
      shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)
      album = shop.items.create(name: "SJ TimeSlip", description: "Album", price: 30, image: "https://images-na.jpg", inventory: 30)

      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      create1 = order.created_at.to_formatted_s(:long)
      update1 = order.updated_at.to_formatted_s(:long)

      ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order.id)
      ItemOrder.create(item: album, price: album.price, quantity: 3, order_id: order.id)

      visit default_user_profile_orders_path

      click_on "#{order.id}"

      expect(current_path).to eq("/default_user/profile/orders/#{order.id}")

      expect(page).to have_content("Order Number: #{order.id}")
      expect(page).to have_content("Order Placed: #{create1}")
      expect(page).to have_content("Last Updated: #{update1}")
      expect(page).to have_content("Status: #{order.status}")
      expect(page).to have_content("2")
      expect(page).to have_content("unfulfilled")
      expect(page).to have_content("$2,090.00")
      expect(page).to have_content("EXO Kai Cardboard")
      expect(page).to have_content("Just a cutout")
      expect(page).to have_content("$100.00")
      expect(page).to have_content("20")

    end
  end
end

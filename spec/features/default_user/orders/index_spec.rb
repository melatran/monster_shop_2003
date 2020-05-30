require "rails_helper"

RSpec.describe "Default User's Profile Orders Page" do
 describe "when I visit my profile page" do
   describe "I can see a link to My Orders" do
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
 end
end

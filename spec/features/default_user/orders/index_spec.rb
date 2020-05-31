require "rails_helper"

RSpec.describe "Default User's Profile Orders Page" do
     it "shows a link to My Orders when I have placed orders" do

       shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
       cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 10000, image: "https://images-na.jpg", inventory: 20)

       user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

       order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
       ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order.id)


       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

       visit default_user_profile_path

       click_on "My Orders"

       expect(current_path).to eq(default_user_profile_orders_path)
     end

     it "I cannot see a link to My Orders when I haven't placed an order" do

       default_user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

       visit default_user_profile_path
       expect(page).to_not have_content("My Orders")
     end

     it "I can see a list of every order I've made" do
       shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
       cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)

       user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

       order1 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, created_at: "May 30, 2020 18:54")
       order2 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
       create1 = order1.created_at.to_formatted_s(:long)
       update1 = order1.updated_at.to_formatted_s(:long)

       ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 2, order_id: order1.id)
       ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 3, order_id: order2.id)

       visit default_user_profile_orders_path

       within ".orders-#{order1.id}" do
         expect(page).to have_content("Order Number: #{order1.id}")
         expect(page).to have_link("#{order1.id}")
         expect(page).to have_content("Order Placed: #{create1}")
         expect(page).to have_content("Last Updated: #{update1}")
         expect(page).to have_content("Status: #{order1.status}")
         expect(page).to have_content("Total Quantity: 2")
         expect(page).to have_content("Grand Total: $200")
         expect(page).to_not have_content("Order Number: #{order2.id}")
       end

       within ".orders-#{order2.id}" do
         expect(page).to have_content("Order Number: #{order2.id}")
         expect(page).to have_link("#{order2.id}")
         expect(page).to have_content("Total Quantity: 3")
         expect(page).to have_content("Grand Total: $300")
         expect(page).to_not have_content("Order Number: #{order1.id}")
       end
     end
end

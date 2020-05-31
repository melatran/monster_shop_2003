require "rails_helper"

RSpec.describe "Cancelling An Order" do
  before :each do
    @shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @cardboard = @shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)

    @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    ItemOrder.create(item: @cardboard, price: @cardboard.price, quantity: 20, order_id: @order.id)
  end

  it "I can cancel my order and it will display a flash message" do

    visit "/default_user/profile/orders/#{@order.id}"

    click_on "Cancel Order"

    expect(current_path).to eq(default_user_profile_path)
    expect(page).to have_content("Your Order Has Been Cancelled")
  end
end




# User Story 30, User cancels an order
#
# As a registered user
# When I visit an order's show page
# I see a button or link to cancel the order
# When I click the cancel button for an order, the following happens: <=
# - Each row in the "order items" table is given a status of "unfulfilled"
# - The order itself is given a status of "cancelled"
# - Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
# - I am returned to my profile page
# - I see a flash message telling me the order is now cancelled <=
# - And I see that this order now has an updated status of "cancelled" <=

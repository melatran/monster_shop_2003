require "rails_helper"

RSpec.describe "Merchant Order Show Page" do
  before :each do
    #shop
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @merchant_user = User.create(name: "Brian", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Brian@gmail.com", password: "asdf", role: 1, merchant_id: "#{@bike_shop.id}")

     #order
    @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen2@hotmail.com", password: "arrow", role: 0)
    @order_1 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    @orderitem1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it "merchant fulfils part of an order if not already fulfilled" do
    visit "/items/#{@tire.id}"
    expect(page).to have_content("Inventory: 12")

    visit "/merchant/orders/#{@order_1.id}"

    within ".order-#{@orderitem1.id}" do
      expect(page).to have_content("Status: unfulfilled")
      click_link "Fulfill Item"
    end

    expect(current_path).to eq("/merchant/orders/#{@order_1.id}")
    expect(page).to have_content("You have fulfilled the item")

    within ".order-#{@orderitem1.id}" do
      expect(page).to have_content("Status: fulfilled")
    end

    visit "/items/#{@tire.id}"
    expect(page).to have_content("Inventory: 10")
  end

  it "user wont see fulfil button if itm is fulfilled" do
    order2 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    orderitem2 = order2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 1)

    visit "/merchant/orders/#{order2.id}"

    within ".order-#{orderitem2.id}" do
      expect(page).to have_content("Status: fulfilled")
      expect(page).to have_content("You have fulfilled the item")
      expect(page).to_not have_content("Fulfill Item")
    end
  end

  it "user can't fulfil item when not enough stock" do
    helmet = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
    order2 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    orderitem2 = order2.item_orders.create!(item: helmet, price: helmet.price, quantity: 6)

    visit "/merchant/orders/#{order2.id}"
  
    within ".order-#{orderitem2.id}" do
      expect(page).to have_content("You don't have enough in stock")
    end
  end
end

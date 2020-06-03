require 'rails_helper'

RSpec.describe "merchant sees an order show page" do
  describe "do this before each" do
    before(:each) do

      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @merchant_user = User.create(name: "Brian", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Brian@gmail.com", password: "asdf", role: 1, merchant_id: "#{@bike_shop.id}")
      @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen2@hotmail.com", password: "arrow", role: 0)
      @order_1 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @user2 = User.create(name: "Rostam", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Rm@gmail.com", password: "asdfghjkl", role: 0)
      @order_2 = Order.create!(name: 'Rostam', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, user_id: @user2.id)
      @order_3 = Order.create!(name: 'Rostam', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, user_id: @user2.id)

      @orderitem1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 1)
      @orderitem2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: 1)
      @orderitem3 = @order_2.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2, status: 1)
      @orderitem4 = @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2, status: 1)
      @orderitem5 = @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: 1)
      @orderitem6 = @order_3.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 5, status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end

    it "shows receipients name and address " do
      visit "/merchant/dashboard"
      click_on "Orders"
      has_link? "#{@order_1.name}"
      expect(page).to have_content("#{@order_1.address}")
      expect(page).to have_content("#{@orderitem1.item.name}")
      first(".img-thumbnail-#{@orderitem1.item.id}").present?
      expect(page).to have_content("#{@orderitem1.price}")
      expect(page).to have_content("#{@orderitem1.quantity}")
      expect(page).to_not have_content("#{@orderitem2.item.name}")
      expect(page).to_not have_content("#{@orderitem3.item.name}")

    end



    end



  end

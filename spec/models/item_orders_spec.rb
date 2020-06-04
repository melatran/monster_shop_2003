require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    it 'subtotal' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

      expect(item_order_1.subtotal).to eq(200)
    end
  end

  describe 'status' do
    it "can assign an order is unfulfilled" do
      shop = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      cardboard = shop.items.create(name: "EXO Kai Cardboard", description: "Just a cutout", price: 100, image: "https://images-na.jpg", inventory: 20)

      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      order = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      item_order = ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order.id)

      expect(item_order.status).to eq("unfulfilled")
    end
  end

  describe "fulfillment ability" do
    it "has inventory and unfulfilled" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      merchant_user = User.create(name: "Brian", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Brian@gmail.com", password: "asdf", role: 1, merchant_id: "#{bike_shop.id}")

       #order
      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen2@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      orderitem1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

      expect(orderitem1.can_be_fulfilled?).to eq(true)
    end

    it "doesn't have inventory and it's unfulfilled" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      merchant_user = User.create(name: "Brian", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Brian@gmail.com", password: "asdf", role: 1, merchant_id: "#{bike_shop.id}")

       #order
      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen2@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      orderitem1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 7)

      expect(orderitem1.can_be_fulfilled?).to eq(false)
    end

    it "has inventory and it's fulfilled" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      merchant_user = User.create(name: "Brian", address: "123 West 4th", city: "Sterling", state: "Virginia", zip: "92383", email: "Brian@gmail.com", password: "asdf", role: 1, merchant_id: "#{bike_shop.id}")

       #order
      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen2@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create!(name: 'Natasha', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      orderitem1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 7, status: 1)

      expect(orderitem1.can_be_fulfilled?).to eq(false)
    end
  end
end

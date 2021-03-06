require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @bucky = @brian.users.create(name: "Bucky Barnes",
        address: "126 Fifth Avenue",
        city: "Queens",
        state: "New York",
        zip: "10010",
        email: "wintersoldier@hotmail.com",
        password: "america",
        role: 1)

      @bill = @meg.users.create(name: "Billy Potato",
        address: "11 Main St. ",
        city: "Queens",
        state: "New York",
        zip: "10010",
        email: "wintersoldier@hotmail.com",
        password: "america",
        role: 1)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @item_order1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'total_quantity' do
      expect(@order_1.total_quantity).to eq(5)
    end

    it 'cancel' do
      expect(@order_1.status).to eq("pending")

      @order_1.cancel

      expect(@order_1.status).to eq("cancelled")
      expect(@item_order1.status).to eq("unfulfilled")
    end

    it ' grandtotal_for_merchant' do
      expect(@order_1.grandtotal_for_merchant(@bucky)).to eq(30)
      expect(@order_1.grandtotal_for_merchant(@bill)).to eq(200)
    end
  end
end

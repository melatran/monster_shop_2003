require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)

      @user = User.create(name: "Meg", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @item_order1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end
    
    it 'total_in_order' do
      expect(@pull_toy.total_in_order(@order_1.id, @pull_toy.id)).to eq(3)
      expect(@tire.total_in_order(@order_1.id, @tire.id)).to eq(2)
    end
    
    it 'subtotal_item' do     
      expect(@pull_toy.subtotal_item(@order_1.id, @pull_toy.id)).to eq(30)
      expect(@tire.subtotal_item(@order_1.id, @tire.id)).to eq(200)
    end

    it 'never_sold?' do
      expect(@chain.never_sold?(@chain.id)).to eq(true)
      expect(@pull_toy.never_sold?(@pull_toy.id)).to eq(false)
      expect(@tire.never_sold?(@tire.id)).to eq(false)
    end
  end

  describe 'class methods' do 
    it ".popularity for most" do
      shop1 = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      shop2 = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      #Shop 2 items
      cardboard = shop2.items.create(name: "EXO Kai' Cardboard", description: "Just a cutout, not the real deal!", price: 10000, image: "https://images-na.jpg", inventory: 20)
      album = shop2.items.create(name: "Super Junior Time Slip", description: "Comeback CD", price: 55, image: "https://images-na.jpg", inventory: 120)
      ahgabong = shop2.items.create(name: "GOT7 Ahgabong", description: "True Ahgases Only", price: 100, image: "https://images-na.jpg", inventory: 70)
      dolls = shop2.items.create(name: "All Day6 Member Dolls", description: "Time of your life", price: 600, image: "https://images-na.jpg", inventory: 12)

      #Shop 1 items
      paper = shop1.items.create(name: "Lined Paper", price: 20)
      pencil = shop1.items.create(name: "Yellow Pencil", description: "You can write with it!", price: 2, image: "https://images-na.jpg", inventory: 100)
      journal = shop1.items.create(name: "Bullet Journal", description: "DIY Planner", price: 2, image: "https://images-na.jpg", inventory: 200)
      fan = shop1.items.create(name: "Personal Fan", description: "Cool Down Whenever", price: 35, image: "https://images-na.jpg", inventory: 100)

      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create(name: 'Hyram', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)

      ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order_1.id)
      ItemOrder.create(item: ahgabong, price: ahgabong.price, quantity: 55, order_id: order_1.id)
      ItemOrder.create(item: album, price: album.price, quantity: 80, order_id: order_1.id)
      ItemOrder.create(item: journal, price: journal.price, quantity: 70, order_id: order_1.id)
      ItemOrder.create(item: dolls, price: dolls.price, quantity: 10, order_id: order_1.id)
      ItemOrder.create(item: fan, price: fan.price, quantity: 2, order_id: order_1.id)
      ItemOrder.create(item: paper, price: paper.price, quantity: 3, order_id: order_1.id)
      ItemOrder.create(item: pencil, price: pencil.price, quantity: 1, order_id: order_1.id)

      expect(Item.popularity('desc')).to eq([album, journal, ahgabong, cardboard, dolls])
    end

    it ".popularity for least" do
      shop1 = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      shop2 = Merchant.create(name: "K-Pop Black Market", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      #Shop 2 items
      cardboard = shop2.items.create(name: "EXO Kai' Cardboard", description: "Just a cutout, not the real deal!", price: 10000, image: "https://images-na.jpg", inventory: 20)
      album = shop2.items.create(name: "Super Junior Time Slip", description: "Comeback CD", price: 55, image: "https://images-na.jpg", inventory: 120)
      ahgabong = shop2.items.create(name: "GOT7 Ahgabong", description: "True Ahgases Only", price: 100, image: "https://images-na.jpg", inventory: 70)
      dolls = shop2.items.create(name: "All Day6 Member Dolls", description: "Time of your life", price: 600, image: "https://images-na.jpg", inventory: 12)

      #Shop 1 items
      paper = shop1.items.create(name: "Lined Paper", price: 20)
      pencil = shop1.items.create(name: "Yellow Pencil", description: "You can write with it!", price: 2, image: "https://images-na.jpg", inventory: 100)
      journal = shop1.items.create(name: "Bullet Journal", description: "DIY Planner", price: 2, image: "https://images-na.jpg", inventory: 200)
      fan = shop1.items.create(name: "Personal Fan", description: "Cool Down Whenever", price: 35, image: "https://images-na.jpg", inventory: 100)

      user = User.create(name: "Natasha Romanoff", address: "890 Fifth Avenue", city: "Manhattan", state: "New York", zip: "10010", email: "spiderqueen@hotmail.com", password: "arrow", role: 0)
      order_1 = Order.create(name: 'Hyram', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)

      ItemOrder.create(item: cardboard, price: cardboard.price, quantity: 20, order_id: order_1.id)
      ItemOrder.create(item: ahgabong, price: ahgabong.price, quantity: 55, order_id: order_1.id)
      ItemOrder.create(item: album, price: album.price, quantity: 80, order_id: order_1.id)
      ItemOrder.create(item: journal, price: journal.price, quantity: 70, order_id: order_1.id)
      ItemOrder.create(item: dolls, price: dolls.price, quantity: 10, order_id: order_1.id)
      ItemOrder.create(item: fan, price: fan.price, quantity: 2, order_id: order_1.id)
      ItemOrder.create(item: paper, price: paper.price, quantity: 3, order_id: order_1.id)
      ItemOrder.create(item: pencil, price: pencil.price, quantity: 1, order_id: order_1.id)

      expect(Item.popularity('asc')).to eq([pencil, fan, dolls, cardboard, ahgabong])
    end
  

  end
end

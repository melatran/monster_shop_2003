require 'rails_helper'

RSpec.describe "As a merchant employee user" do
    describe "when I visit my merchant dashboard" do
        before(:each) do
            
            @bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            @employee = @bike_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)  
        end

        it "I see the name and full address of the merchant that I work for" do

            visit "/merchant/dashboard"

            expect(page).to have_content("#{@bike_shop.name}")
        end

        it "I see a link to view my own items. This link routes to /merchant/items" do
            tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
            helmet = @bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)

            visit "/merchant/dashboard"

            click_link "View items sold by #{@employee.merchant.name}"

            expect(current_path).to eq("/merchant/items")

            expect(page).to have_content("#{tire.name}")
            expect(page).to have_content("#{helmet.name}")
        end

        it "I see a list of pending orders containing items that I sell" do

            dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
            pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
            dog_bone = dog_shop.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
            
            tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
            helmet = @bike_shop.items.create!(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)
            
            user = User.create!(name: "Josh T",
                                       address: "11 Main St.",
                                       city: "Denver",
                                       state: "CO",
                                       zip: "80209",
                                       email: "josht@gmail.com",
                                       password: "123",
                                       role: 0) 

            user2 = User.create!(name: "Ed M",
                                       address: "22 Spruce Lane",
                                       city: "Atlanta",
                                       state: "GA",
                                       zip: "30321",
                                       email: "ed@gmail.com",
                                       password: "676",
                                       role: 0) 

            order = Order.create!(name: 'Josh T',
                                 address: '11 Main St.', 
                                 city: 'Denver', 
                                 state: 'CO', 
                                 zip: 80209, 
                                 user_id: user.id)

            order2 = Order.create!(name: 'Ed M',
                                 address: '22 Spruce Lane', 
                                 city: 'Atlanta', 
                                 state: 'GA', 
                                 zip: 30321, 
                                 user_id: user2.id)

            order3 = Order.create!(name: 'Mel',
                                 address: '22 Spruce Lane', 
                                 city: 'Atlanta', 
                                 state: 'GA', 
                                 zip: 30321,
                                 status: 0, 
                                 user_id: user2.id)

            ItemOrder.create(item: pull_toy, price: pull_toy.price, quantity: 2, order_id: order.id)
            ItemOrder.create(item: dog_bone, price: dog_bone.price, quantity: 2, order_id: order.id)
            ItemOrder.create(item: tire, price: tire.price, quantity: 2, order_id: order.id)

            ItemOrder.create(item: pull_toy, price: pull_toy.price, quantity: 2, order_id: order2.id)
            ItemOrder.create(item: helmet, price: helmet.price, quantity: 2, order_id: order2.id)
            ItemOrder.create(item: tire, price: tire.price, quantity: 2, order_id: order2.id)

            visit "/merchant/dashboard"

            within ".order-#{order.id}" do
                expect(page).to have_content(tire.name)
                expect(page).to_not have_content(dog_bone.name)
                expect(page).to_not have_content(pull_toy.name)
            end

            within ".order-#{order2.id}" do
                expect(page).to have_content(tire.name)
                expect(page).to have_content(helmet.name)
                expect(page).to_not have_content(pull_toy.name)
            end
        end
    end
end
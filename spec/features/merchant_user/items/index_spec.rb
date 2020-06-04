require 'rails_helper'

RSpec.describe "As a merchant employee user" do
    describe "when I visit my items index page" do

        it "has a link next to each item that has never been ordered to delete that item" do
            dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
            bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            
            employee = dog_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 

            user = User.create!(name: "Josh T",
                                       address: "11 Main St.",
                                       city: "Denver",
                                       state: "CO",
                                       zip: "80209",
                                       email: "josht@gmail.com",
                                       password: "123",
                                       role: 0) 
                    
            order = Order.create!(name: 'Josh T',
                                 address: '11 Main St.', 
                                 city: 'Denver', 
                                 state: 'CO', 
                                 zip: 80209, 
                                 user_id: user.id)

                                 
            tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
            helmet = bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)
                                 
            pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
            dog_bone = dog_shop.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
            leash = dog_shop.items.create!(name: "Leash", description: "You'll never lose your dog!", price: 15, image: "https://img.chewy.com/is/image/catalog/174402_MAIN._AC_SL1500_V1559223768_.jpg", inventory: 3)

            ItemOrder.create(item: pull_toy, price: pull_toy.price, quantity: 1, order_id: order.id)
            ItemOrder.create(item: dog_bone, price: dog_bone.price, quantity: 2, order_id: order.id)
            ItemOrder.create(item: tire, price: tire.price, quantity: 1, order_id: order.id)            
            ItemOrder.create(item: helmet, price: helmet.price, quantity: 1, order_id: order.id)            

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)  

            visit "/merchant/items"

            within ".item-#{pull_toy.id}" do
                expect(page).to_not have_link("Delete Item")
            end

            within ".item-#{dog_bone.id}" do
                expect(page).to_not have_link("Delete Item")
            end

            within ".item-#{leash.id}" do
                expect(page).to have_link("Delete item")
                click_link "Delete item"
            end
             
            expect(page).to have_content("#{leash.name} has been deleted")         
            expect(page).to have_content(pull_toy.name)
            expect(page).to have_content(dog_bone.name)
            #expect(page).to_not have_css(".item-#{leash.id}")

        end
        
        it 'it has a link to add a new item' do
            dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
            employee = dog_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)  

            visit "/merchant/items"

            click_link "Add new item"
        end
    end
  describe "when merchant employee visits index page" do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @employee = @bike_shop.users.create(name: "Employee user",
                                 address: "99 Working Hard Lane",
                                 city: "Los Angeles",
                                 state: "California",
                                 zip: "90210",
                                 email: "employee_email@gmail.com",
                                 password: "employee_password",
                                 role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @helmet = @bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)
    end

    it "can display the information of each item the merchant sells" do

      visit "/merchant/items"

      within ".item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_css("img[src='#{@tire.image}']")
        expect(page).to have_content(@tire.description)
        expect(page).to have_content(@tire.price)
        expect(page).to have_content(@tire.inventory)
        expect(page).to have_content("Active")
      end

      within ".item-#{@helmet.id}" do
        expect(page).to have_content(@helmet.name)
        expect(page).to have_css("img[src='#{@helmet.image}']")
        expect(page).to have_content(@helmet.description)
        expect(page).to have_content(@helmet.price)
        expect(page).to have_content(@helmet.inventory)
        expect(page).to have_content("Active")
      end
    end
  end
end

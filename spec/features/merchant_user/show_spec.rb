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
    end
end
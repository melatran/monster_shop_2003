require 'rails_helper'

RSpec.describe 'As an admin user' do
    describe 'site navigation' do
        it 'I am not able to access any path that begins with /merchant or /cart' do
                               
          admin = User.create(name: "Admin user",
                                       address: "123 Boss Rd",
                                       city: "Denver",
                                       state: "Colorado",
                                       zip: "81111",
                                       email: "admin_email@gmail.com",
                                       password: "admin_password",
                                       role: 2) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)  

            visit '/merchant/dashboard' 

            expect(page).to have_content("The page you were looking for doesn't exist.")
            
            visit '/cart'
            
            expect(page).to have_content("This page does not exist for you")
                  
        end 

        it "when I visit merchants index page and I click on a merchants name I am taken to '/admin/merchants/:merchant_id' and I see everything the that merchant user does" do
            
            bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            employee = bike_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 

            admin = User.create(name: "Admin user",
                                       address: "123 Boss Rd",
                                       city: "Denver",
                                       state: "Colorado",
                                       zip: "81111",
                                       email: "admin_email@gmail.com",
                                       password: "admin_password",
                                       role: 2) 

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin) 
            
            visit "/merchants"

            click_link "Meg's Bike Shop"

            expect(current_path).to eq("/admin/merchants/#{bike_shop.id}")
            expect(page).to have_content(bike_shop.name)
            expect(page).to have_content(bike_shop.address)
            expect(page).to have_content(bike_shop.city)
            expect(page).to have_content(bike_shop.state)
            expect(page).to have_content(bike_shop.zip)
            expect(page).to have_link("View items sold by #{bike_shop.name}")
        end
    end 
end 
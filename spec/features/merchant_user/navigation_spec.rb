require 'rails_helper'

RSpec.describe 'As a merchant user' do
    describe 'site navigation' do
        it 'I am not able to access any path that begins with /admin' do
            bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            employee = bike_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)  

            visit '/admin/dashboard' 

            expect(page).to have_content("The page you were looking for doesn't exist.")
                  
        end 
    end 
end 
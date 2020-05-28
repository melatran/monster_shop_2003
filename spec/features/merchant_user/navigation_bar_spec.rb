require 'rails_helper'

RSpec.describe 'As an merchant employee user' do
    describe 'in the navigation bar' do
        it 'I see links to home page, items index page, merchants index page, dashboard, logout, and profile page' do

            employee = User.create(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)  

            visit "/merchant/dashboard"

            within 'nav' do
                expect(page).to have_link("Home")
                expect(page).to have_link("All Merchants")
                expect(page).to have_link("All Items")
                expect(page).to have_link("Cart: 0")
                expect(page).to have_link("Merchant Dashboard")
                expect(page).to_not have_link("Login")
                expect(page).to_not have_link("Register")
            end
        end
    end
end
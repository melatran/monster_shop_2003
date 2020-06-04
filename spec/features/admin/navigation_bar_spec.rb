require 'rails_helper'

RSpec.describe 'As an admin user' do
    describe 'navigation bar' do
        it 'I see links to home page, items index page, merchants index page, dashboard, logout, and profile page' do

            admin = User.create(name: "Admin user",
                                       address: "123 Boss Rd",
                                       city: "Denver",
                                       state: "Colorado",
                                       zip: "81111",
                                       email: "admin_email@gmail.com",
                                       password: "admin_password",
                                       role: 2)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit "/admin/dashboard"

            within 'nav' do
                expect(page).to have_link("Home")
                expect(page).to have_link("All Merchants")
                expect(page).to have_link("All Items")
                expect(page).to have_link("All Users")
                expect(page).to have_link("Dashboard")
                expect(page).to_not have_link("Login")
                expect(page).to_not have_link("Register")
                expect(page).to_not have_link("Cart: 0")
            end
        end
    end
end

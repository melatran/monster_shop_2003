require 'rails_helper'

RSpec.describe 'As a default user' do
    describe 'in navigation bar' do
        it 'I see links to home page, items index page, merchants index page, cart, logout, and profile page' do

            default_user = User.create(name: "Default user",
                                       address: "55 Regular Person Lane",
                                       city: "Boulder",
                                       state: "Colorado",
                                       zip: "80209",
                                       email: "default_email@gmail.com",
                                       password: "default_password",
                                       role: 0) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)  

            visit "default_user/profile"

            within 'nav' do
                expect(page).to have_link("Home")
                expect(page).to have_link("All Merchants")
                expect(page).to have_link("All Items")
                expect(page).to have_link("User Profile")
                expect(page).to_not have_link("Login")
                expect(page).to_not have_link("Register")
            end


        end
    end
end
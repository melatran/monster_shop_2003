require 'rails_helper'

RSpec.describe 'As a visitor' do
    describe 'when I visit registration page' do
        it 'shows a message when I do not fill out the registration page completely' do

            visit '/register'

            name = "John Smith"
            address = "123 Main St."
            city = "Denver"
            state = "Colorado"
            zip = "80209"
            email = "example_email@gmail.com"
            password = "password"

            #fill_in :name, with: name
            fill_in :address, with: address
            fill_in :city, with: city
            fill_in :state, with: state
            fill_in :zip, with: zip
            fill_in :email, with: email
            fill_in :password, with: password

            click_on "Create Account"
            
            expect(page).to have_content("Name can't be blank")

            visit '/register'

            name = "John Smith"
            address = "123 Main St."
            city = "Denver"
            state = "Colorado"
            zip = "80209"
            email = "example_email@gmail.com"
            password = "password"

            fill_in :name, with: name
            #fill_in :address, with: address
            fill_in :city, with: city
            fill_in :state, with: state
            fill_in :zip, with: zip
            fill_in :email, with: email
            fill_in :password, with: password

            click_on "Create Account"

            expect(page).to have_content("Address can't be blank")

            visit '/register'

            name = "John Smith"
            address = "123 Main St."
            city = "Denver"
            state = "Colorado"
            zip = "80209"
            email = "example_email@gmail.com"
            password = "password"

            fill_in :name, with: name
            fill_in :address, with: address
            #fill_in :city, with: city
            fill_in :state, with: state
            fill_in :zip, with: zip
            fill_in :email, with: email
            fill_in :password, with: password

            click_on "Create Account"

            expect(page).to have_content("City can't be blank")

            visit '/register'

            name = "John Smith"
            address = "123 Main St."
            city = "Denver"
            state = "Colorado"
            zip = "80209"
            email = "example_email@gmail.com"
            password = "password"

            fill_in :name, with: name
            fill_in :address, with: address
            fill_in :city, with: city
            #fill_in :state, with: state
            fill_in :zip, with: zip
            fill_in :email, with: email
            fill_in :password, with: password

            click_on "Create Account"

            expect(page).to have_content("State can't be blank")

            visit '/register'

            name = "John Smith"
            address = "123 Main St."
            city = "Denver"
            state = "Colorado"
            zip = "80209"
            email = "example_email@gmail.com"
            password = "password"

            fill_in :name, with: name
            fill_in :address, with: address
            fill_in :city, with: city
            fill_in :state, with: state
            #fill_in :zip, with: zip
            fill_in :email, with: email
            fill_in :password, with: password

            click_on "Create Account"

            expect(page).to have_content("Zip can't be blank")
        end
    end
end

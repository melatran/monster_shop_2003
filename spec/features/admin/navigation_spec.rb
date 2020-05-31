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
    end
end

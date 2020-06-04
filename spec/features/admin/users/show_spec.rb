require 'rails_helper'

RSpec.describe "As an admin user" do
    describe "when I visit a user's profile page " do 
        it "I see the same information as the user but without link to edit profile" do
            admin = User.create(name: "Michael Scott",
                        address: "123 Boss Rd",
                        city: "Denver",
                        state: "Colorado",
                        zip: "81111",
                        email: "admin_email@gmail.com",
                        password: "admin_password",
                        role: 2)

            user = User.create(name: "Natasha Romanoff",
                            address: "890 Fifth Avenue",
                            city: "Manhattan",
                            state: "New York",
                            zip: "10010",
                            email: "spiderqueen@hotmail.com",
                            password: "arrow",
                            role: 0)

            order1 = Order.create(name: 'Natasha Romanoff', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id, created_at: "May 30, 2020 18:54", status: 1)
            
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit "/admin/users/#{user.id}"

            expect(page).to have_content(user.name)
            expect(page).to have_content(user.address)
            expect(page).to have_content(user.city)
            expect(page).to have_content(user.state)
            expect(page).to have_content(user.zip)
            expect(page).to have_content(user.email)

            expect(page).to have_link("#{user.name}'s Orders")   

            click_link "#{user.name}'s Orders"       
            expect(current_path).to eq("/admin/users/#{user.id}/orders") 
        end
    end
end
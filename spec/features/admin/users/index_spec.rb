require "rails_helper"

RSpec.describe "Admin User Index Page" do
  it "can display all users in the system" do

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

    user2 = User.create(name: "Bucky Barnes",
                      address: "890 Fifth Avenue",
                      city: "Manhattan",
                      state: "New York",
                      zip: "10010",
                      email: "wintersoldier@hotmail.com",
                      password: "america",
                      role: 1)

    employee = User.create(name: "Mike's Print Shop",
                          address: "99 Working Hard Lane",
                          city: "Los Angeles",
                          state: "California",
                          zip: "90210",
                          email: "employee_email@gmail.com",
                          password: "employee_password",
                          role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/users"

    within ".users-#{user.id}" do
      expect(page).to have_link("Natasha Romanoff")
      expect(page).to have_content("Registered Date: #{user.created_at.to_formatted_s(:long)}")
      expect(page).to have_content("Type of User: default")
    end

    within ".users-#{user2.id}" do
      expect(page).to have_link("Bucky Barnes")
      expect(page).to have_content("Registered Date: #{user2.created_at.to_formatted_s(:long)}")
      expect(page).to have_content("Type of User: merchant")
    end

    within ".users-#{employee.id}" do
      expect(page).to have_link("Mike's Print Shop")
      expect(page).to have_content("Registered Date: #{employee.created_at.to_formatted_s(:long)}")
      expect(page).to have_content("Type of User: merchant")
    end

    within ".users-#{admin.id}" do
      expect(page).to have_link("Michael Scott")
      expect(page).to have_content("Registered Date: #{admin.created_at.to_formatted_s(:long)}")
      expect(page).to have_content("Type of User: admin")
    end
  end

  it "admin can click on name to user show page" do
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/users"
    
    click_link "Natasha Romanoff"
    expect(current_path).to eq("/admin/users/#{user.id}")
  end
end

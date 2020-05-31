require 'rails_helper'

RSpec.describe "User can edit their profile data" do
  it "prepopulates a form for the user to update" do
    default_user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow",
      role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit default_user_profile_path

      click_on("Edit Profile")

      has_field?("Name", with: "#{default_user.name}")
      has_field?("Address", with: "#{default_user.address}")
      has_field?("City", with: "#{default_user.city}")
      has_field?("State", with: "#{default_user.state}")
      has_field?("Zip", with: "#{default_user.zip}")
      has_field?("Email", with: "#{default_user.email}")

      fill_in "Name", with: "Bruce Banner"

      click_on("Submit update")

      expect(current_path).to eq("/default_user/profile")
      expect(page).to have_content("Your data was updated")
      expect(page).to have_content("Bruce Banner")
      expect(page).to_not have_content("Natasha Romanoff")
      expect(page).to have_content(default_user.address)
      expect(page).to have_content(default_user.city)
      expect(page).to have_content(default_user.state)
      expect(page).to have_content(default_user.zip)
      expect(page).to have_content(default_user.email)
      expect(page).to_not have_content(default_user.password)
  end
  
  it "gives errors if fields not entered" do
    default_user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "forever@hotmail.com",
      password: "arrow",
      role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit default_user_profile_path

      click_on("Edit Profile")

      fill_in "Name", with: ""

      click_on("Submit update")

      expect(current_path).to eq("/default_user/profile/edit")
      expect(page).to have_content("Name can't be blank")

    end
  
    it "user can't update profile with an existing email" do
      default_user = User.create(name: "Natasha Romanoff",
        address: "890 Fifth Avenue",
        city: "Manhattan",
        state: "New York",
        zip: "10010",
        email: "forever@hotmail.com",
        password: "arrow",
        role: 0)
      existing_user = User.create(name: "Peter Parker",
        address: "890 Fifth Avenue",
        city: "Manhattan",
        state: "New York",
        zip: "10010",
        email: "spiderqueen@hotmail.com",
        password: "tony",
        role: 0)
      
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)
      
        click_on("Edit Profile")
        fill_in "Email", with: "spiderqueen@hotmail.com"
        click_on("Submit update")

        expect(page).to have_content("Email has already been taken")
  end
end

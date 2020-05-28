require 'rails_helper'

RSpec.describe "When i visit my proile page" do
  it "shows all of my profile data on the page except password and a link to edit my profile data" do

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

      has_link?("Edit Profile")
      click_link("Edit Profile")

      expect(current_path).to eq(default_user_profile_edit_path)
  end

end

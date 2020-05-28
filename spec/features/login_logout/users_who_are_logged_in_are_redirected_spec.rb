require 'rails_helper'

RSpec.describe "As a registered user, merchant, or admin" do
  it "redirects to the according page" do
    user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow",
      role: 1)

      visit merchant_path

      within 'nav' do
        click_link "Login"
      end

    fill_in :username, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    visit login_path

    
  end

end

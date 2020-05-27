require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials as a user" do
    user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow",
      role: 0)

    visit "/merchants"

    within 'nav' do
      click_link "Login"
    end

    expect(current_path).to eq('/login')

    fill_in :username, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(current_path).to eq('/profile')

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "can log in with valid credentials as a merchant" do
    user = User.create(name: "Bucky Barnes",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "wintersoldier@hotmail.com",
      password: "america",
      role: 1)

      visit "/merchants"

      within 'nav' do
        click_link "Login"
      end

      fill_in :username, with: user.email
      fill_in :password, with: user.password

      click_button "Login"
      save_and_open_page
      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("Welcome, #{user.name}")
  end
end

# [ ] done
# User Story 13, User can Login
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

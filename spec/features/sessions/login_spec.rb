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

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("Welcome, #{user.name}")
  end

  it "can log in with valid credentials as an admin" do

    user = User.create(name: "Blair Waldor",
      address: "1136 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "gossipgirl@hotmail.com",
      password: "xoxo",
      role: 2)

      visit "/merchants"

      within 'nav' do
        click_link "Login"
      end

      fill_in :username, with: user.email
      fill_in :password, with: user.password

      click_button "Login"
      
      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content("Welcome, #{user.name}")
  end
end

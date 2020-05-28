require 'rails_helper'

RSpec.describe "a user can log out" do
  it "redirects to welcome page" do
    user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow",
      role: 0)

      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/login"

      fill_in :username, with: user.email
      fill_in :password, with: user.password

      click_button "Login"

      visit "/items"

      click_on chain.name
      click_on "Add To Cart"

      within 'nav' do
        click_on "Logout"
      end

      expect(current_path).to eq("/")
      expect(page).to have_content("You have been logged out")
      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end

  end

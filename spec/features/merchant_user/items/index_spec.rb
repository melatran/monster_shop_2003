require "rails_helper"

RSpec.describe "Merchant Employee Items Index Page" do
  before :each do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @employee = @bike_shop.users.create(name: "Employee user",
                               address: "99 Working Hard Lane",
                               city: "Los Angeles",
                               state: "California",
                               zip: "90210",
                               email: "employee_email@gmail.com",
                               password: "employee_password",
                               role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @helmet = @bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)
  end

  it "can dispplay the information of each item the merchant sells" do

    visit "/merchant/items"

    within ".items-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src='#{@tire.image}']")
      expect(page).to have_content(@tire.description)
      expect(page).to have_content(@tire.price)
      expect(page).to have_content(@tire.inventory)
      expect(page).to have_content("Active")
    end

    within ".items-#{@helmet.id}" do
      expect(page).to have_content(@helmet.name)
      expect(page).to have_css("img[src='#{@helmet.image}']")
      expect(page).to have_content(@helmet.description)
      expect(page).to have_content(@helmet.price)
      expect(page).to have_content(@helmet.inventory)
      expect(page).to have_content("Active")
    end
  end
end

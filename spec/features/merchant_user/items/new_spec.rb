require 'rails_helper'

RSpec.describe "As a merchant employee user" do
    describe "when I go to the new item form page" do
        it "has places to input name, description, an optional thumbnail image string, price and current inventory for new item" do
            bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            employee = bike_shop.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)

            visit "/merchant/items/new"

            name = "Chain"
            description = "This chain will never break!"
            image = "https://www.wigglestatic.com/product-media/101736678/prod179558_Silver_NE_01.jpg?w=430&h=430&a=7"
            price = 25
            inventory = 5

            fill_in :name, with: name
            fill_in :description, with: description
            fill_in :price, with: price
            fill_in :image, with: image
            fill_in :inventory, with: inventory

            click_button "Create Item"


            expect(current_path).to eq("/merchant/items")
            expect(page).to have_content("Chain")
        end
    end
    describe "when I visit my merchant dashboard" do
        before(:each) do

            @bike_shop1 = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
            @employee1 = @bike_shop1.users.create!(name: "Employee user",
                                       address: "99 Working Hard Lane",
                                       city: "Los Angeles",
                                       state: "California",
                                       zip: "90210",
                                       email: "employee_email@gmail.com",
                                       password: "employee_password",
                                       role: 1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee1)
        end


      it "tells me the incorrect data via a flash message" do

        visit "/merchant/items/new"
        click_on "Create Item"
        expect(page).to have_content("All fields must me completed")
      end

      it "gives me error when I fill out partial fourm" do
        visit "/merchant/items/new"
        fill_in :name, with: "Toy"
        click_on "Create Item"
        expect(page).to have_content("All fields must me completed")
        end

      it "error'd when I give partial information" do
        visit "/merchant/items/new"
        fill_in :name, with: "Toy"
        fill_in :description, with: "Plush"
        click_on "Create Item"
        expect(page).to have_content("All fields must me completed")
      end

      it "give me an error when I do not provide a price" do
        visit "/merchant/items/new"
        fill_in :name, with: "Toy"
        fill_in :description, with: "Plush"
        fill_in :price, with: 1
        click_on "Create Item"
        expect(page).to have_content("All fields must me completed")
      end
    end
end

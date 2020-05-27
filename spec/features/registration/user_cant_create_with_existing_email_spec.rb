require "rails_helper"

RSpec.describe "User Registration" do

  before :each do
    @user = User.create(name: "Natasha Romanoff",
      address: "890 Fifth Avenue",
      city: "Manhattan",
      state: "New York",
      zip: "10010",
      email: "spiderqueen@hotmail.com",
      password: "arrow")
  end

  it "can't register an account with an existing email" do


    visit '/register'

    name = "Peter Parker"
    address = "20 Ingram Street"
    city = "Brooklyn"
    state = "New York"
    zip = "11211"
    email = "spiderqueen@hotmail.com"
    password = "stark"

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :email, with: email
    fill_in :password, with: password

    click_on "Create Account"
    save_and_open_page
    expect(page).to have_content("Email has already been taken")
    expect(page).to_not have_content("spiderqueen@hotmail.com")
  end
end

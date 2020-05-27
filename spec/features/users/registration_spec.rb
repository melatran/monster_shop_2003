require 'rails_helper'

RSpec.describe "User can Register" do
  it "shows a form to enter information and once logged in redirects to profile page" do

    visit "/merchants"
    within 'nav' do
      click_on "Register"
    end
    expect(current_path).to eq("/register")

    page.has_field?(:name)
    page.has_field?(:city)
    page.has_field?(:state)
    page.has_field?(:zip)
    page.has_field?(:email)
    page.has_field?(:password)
    page.has_field?(:confirm_password)

    fill_in :name, with: "Test"
    fill_in :address, with: "123 West 3rd Street"
    fill_in :city, with: "Sterling"
    fill_in :state, with: "Virginia"
    fill_in :zip, with: "20166"
    fill_in :email, with: "awesome@gmail.com"
    fill_in :password, with: "asdf"
    fill_in 'confirm_password', with: "asdf"
    click_on "Create Account"
    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are now registered and logged in")
  end

end

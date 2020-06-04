require "rails_helper"

RSpec.describe "Admin Can Deactivate Item" do
  it "when I deactivate an item, I see a flash message and my item's status is inactive" do
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    admin = User.create(name: "Admin user", address: "123 Boss Rd", city: "Denver", state: "Colorado", zip: "81111", email: "admin_email@gmail.com", password: "admin_password", role: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    helmet = bike_shop.items.create(name: "Brain Keeper", description: "Will keep your brain in one piece!", price: 30, image: "https://green.harvard.edu/sites/green.harvard.edu/files/field-feature/explore_area_image/bikehelmet_0.jpg", inventory: 6)

    visit "/admin/merchants/#{bike_shop.id}/items"

    within ".items-#{tire.id}" do
      expect(page).to have_content("Active")
      click_link "Deactivate"
    end

    expect(current_path).to eq("/admin/merchants/#{bike_shop.id}/items")
    expect(page).to have_content("#{tire.name} is no longer for sale")

    tire.reload
    helmet.reload

    expect(tire.active?).to eq(false)
    expect(helmet.active?).to eq(true)
  end
end

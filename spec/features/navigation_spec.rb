
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')

      within 'nav' do
        click_link 'Login'
      end
      expect(current_path).to eq('/login')

      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq('/register')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

    end

    it 'I am not able to access any path that begins with /profile, /merchant, or /admin' do

      visit '/admin/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/merchant/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/default_user/profile'

      expect(page).to have_content("The page you were looking for doesn't exist.")

    end
  end
end

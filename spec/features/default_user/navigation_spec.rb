
require 'rails_helper'

RSpec.describe 'As a default user' do
    describe 'site navigation' do
        it 'I am not able to access any path that begins with /merchant, or /admin' do

            default_user = User.create(name: "Default user",
                                        address: "55 Regular Person Lane",
                                        city: "Boulder",
                                        state: "Colorado",
                                        zip: "80209",
                                        email: "default_email@gmail.com",
                                        password: "default_password",
                                        role: 0) 
                                
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)  
            visit '/default_user/profile'
            
            expect(page).to have_content("Default user")
            visit '/admin/dashboard' 

            expect(page).to have_content("The page you were looking for doesn't exist.")
      
            visit '/merchant/dashboard'
      
            expect(page).to have_content("The page you were looking for doesn't exist.")
        end 

    end 
end 
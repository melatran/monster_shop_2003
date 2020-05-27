require 'rails_helper'

RSpec.describe User, type: :model do

    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}

    
    describe "roles" do
        it "can create an admin user" do

            admin_user = User.create(name: "Admin user",
                                address: "123 Admin Way",
                                city: "New York City",
                                state: "New York",
                                zip: "01020",
                                email: "admin_email@gmail.com",
                                password: "admin_password",
                                role: 2)

            expect(admin_user.role).to eq("admin")
            expect(admin_user.admin?).to be_truthy
        end 

        it 'can create merchant employee user' do

             merchant_user = User.create(name: "Merchant Employee",
                                         address: "456 Employee St.",
                                         city: "Boston",
                                         state: "Massachusetts",
                                         zip: "11123",
                                         email: "merhant_email@gmail.com",
                                         password: "merchant_password",
                                         role: 1)

            expect(merchant_user.role).to eq("merchant")
            expect(merchant_user.merchant?).to be_truthy
        end

        it "can create default user" do

            default_user = User.create(name: "Default user",
                                       address: "55 Regular Person Lane",
                                       city: "Boulder",
                                       state: "Colorado",
                                       zip: "80209",
                                       email: "default_email@gmail.com",
                                       password: "default_password",
                                       role: 0)

            expect(default_user.role).to eq("default")
            expect(default_user.default?).to be_truthy
        end
    end
end 
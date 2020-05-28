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
      it "can be created as a default user" do

        user = User.create(name: "Natasha Romanoff",
          address: "890 Fifth Avenue",
          city: "Manhattan",
          state: "New York",
          zip: "10010",
          email: "spiderqueen@hotmail.com",
          password: "arrow",
          role: 0)

        expect(user.role).to eq("default")
        expect(user.default?).to be_truthy
     end

   it "can be created as a merchant user" do

      user = User.create(name: "Bucky Barnes",
        address: "126 Fifth Avenue",
        city: "Queens",
        state: "New York",
        zip: "10010",
        email: "wintersoldier@hotmail.com",
        password: "america",
        role: 1)

      expect(user.role).to eq("merchant")
      expect(user.merchant?).to be_truthy
    end

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
end
end 

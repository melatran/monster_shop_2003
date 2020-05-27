class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
    validates_presence_of :name,
                          :address,
                          :city,
                          :state,
                          :zip

    validates_presence_of :password, require: true

    has_secure_password

    enum role: {default: 0, merchant: 1, admin: 2}
end

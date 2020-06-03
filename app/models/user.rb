class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
    validates_presence_of :name,
                          :address,
                          :city,
                          :state,
                          :zip


    validates_presence_of :password, require: true, :on => :create

    validates_confirmation_of :password, :message => "Your email and email confirmation must match"

    has_many :orders, dependent: :destroy

    belongs_to :merchant, optional: true

    has_secure_password

    enum role: {default: 0, merchant: 1, admin: 2}

    def items_sold
      merchant.items
    end

end

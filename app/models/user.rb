class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_s
    email
  end

  # WE MOVE THIS LOGIC IN TO WEBHOOK
  # after_create do
  #   stripe_customer = Stripe::Customer.create( email: self.email )
  #   update(stripe_customer_id: stripe_customer.id)
  # end
end

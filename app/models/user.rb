class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_s
    email
  end

  after_create do
    # send this request to the stripe!!!!
    stripe_customer = Stripe::Customer.create( email: self.email )
    # WE MOVED THIS LOGIC IN TO WEBHOOK
  #   update(stripe_customer_id: stripe_customer.id)
 end
end

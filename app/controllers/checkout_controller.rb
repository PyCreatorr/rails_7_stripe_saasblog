class CheckoutController < ApplicationController

    def create

        # if (current_user.stripe_customer_id.present?)
        #     customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        # end 

        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            allow_promotion_codes: true,
            mode: 'payment',

            #line_items:
            
            line_items: [
                {price: 'price_1O8poAFB6XWBwuphradYNRW5', quantity: 1},
            ],
            mode: 'subscription',

            success_url: posts_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: pricing_url,
          })


          render turbo_stream: turbo_stream.append(
            :reload,
            partial: 'shared/reload_script',
            locals: { redirect_url: @session.url })
    end

    def success
    end

    def cancel
    end
end
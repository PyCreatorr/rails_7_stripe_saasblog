class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
        begin
          event = Stripe::Webhook.construct_event(
            # payload, sig_header, Rails.application.credentials[:stripe][:webhook]
            payload, sig_header, ENV["CREDENTIALS_STIPE_WEBHOOK"]
          )
        rescue JSON::ParserError => e
            # Invalid payload
            puts "Error parsing payload: #{e.message}"
            status 400
            return
        rescue Stripe::SignatureVerificationError => e
            # Invalid signature
            puts "Error verifying webhook signature: #{e.message}"
            status 400
            p e
            return
        end
  
      # Handle the event
      when 'checkout.session.completed'
        session = event.data.object 
        @user = User.find_by(stripe_customer_id: session.customer)
        @user.update(subscription_status: 'active')

      when 'checkout.subscription.updated', 'customer.subscription.deleted'
        subscription = event.data.object
        @user = User.find_by(stripe_customer_id: subscription.customer)

        @user.update(
              subscription_status: subscription_status,
              plan: subscription.itemsdata[0].price.lookup_key
              )             
      else 
        puts "Unhandled event type: #{event.type}"
      end        
            
        puts 'PaymentIntent was successful!'
        render status: 200, json: { message: 'success' }
    end
  end




class BillingPortalController < ApplicationController

    def create
        portal_session = Stripe::BillingPortal::Session.create({
            customer: current_user.stripe_customer_id,
            return_url: root_url+ "?session_id={}",
          })

        render turbo_stream: turbo_stream.append(
            :reload,
            partial: 'shared/reload_script',
            locals: { redirect_url: portal_session.url })

    end
end
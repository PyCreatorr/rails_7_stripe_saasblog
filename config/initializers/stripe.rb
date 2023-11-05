#Stripe.api_key = Rails.application.credentials.stripe.secret
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret)

# the same Rails.application.credentials.stripe[:secret]
# Rails.application.credentials[:stripe][:secret]
# Rails.application.credentials.dig(:stripe, :secret)
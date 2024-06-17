# config/initializers/otp-jwt.rb
require 'otp'
# To load the JWT related support.
require 'otp/jwt'

require 'otp/mailer'

# Set to 'none' to disable verification at all.
# OTP::JWT::Token.jwt_algorithm = 'HS256'

# How long the token will be valid.
# OTP::JWT::Token.jwt_lifetime = 60 * 60 * 24

OTP::JWT::Token.jwt_signature_key = 'b001745e5437b15d1fc79160bd637abdfbe68361b8e1c3f1d26f224a82a128dcab95d7062d3dbe503ee80f772bf07f6e1c4480a3f80fe008245bcee1e58674a2'

OTP::Mailer.default subject: 'Your App magic password'
OTP::Mailer.default from: 'from@example.com'
# Tell mailer to use the template from app/views/otp/mailer/otp.html.erb
OTP::Mailer.prepend_view_path(Rails.root.join('app', 'views'))

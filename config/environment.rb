# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MoProto::Application.initialize!

# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.sendgrid.net',
#   :port           => '587',
#   :authentication => :plain,
#   :user_name      => ENV['SENDGRID_USERNAME'],
#   :password       => ENV['SENDGRID_PASSWORD'],
#   :domain         => 'frozen-spire-6104.herokuapp.com',
#   :enable_starttls_auto => true
# }


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.mandrillapp.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['MANDRILL_USERNAME'],
  :password       => ENV['MANDRILL_APIKEY'],
  :domain         => 'frozen-spire-6104.herokuapp.com',
  :enable_starttls_auto => true
}



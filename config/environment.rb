# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => SENDGRID[:username]
  :password       => SENDGRID[:password],
  :domain         => "relationshipforum.org",
  :enable_starttls_auto => true
}

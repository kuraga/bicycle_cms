require 'devise'
require 'devise/orm/active_record'

Devise.setup do |config|
  config.mailer_sender = self.class.admin_email
  # config.mailer = 'Devise::Mailer'           # Configure the class responsible to send e-mails.
  config.authentication_keys = [ :email ]
  # config.http_authenticatable = false        # Tell if authentication through HTTP Basic Auth is enabled.
  config.skip_session_storage = [ :http_auth ] # TODO Что это?
  config.pepper = self.class.pepper if self.class.pepper
  # config.scoped_views = false
  # config.sign_out_all_scopes = true
  # config.navigational_formats = ["*/*", :html]
  config.sign_out_via = :get
  config.router_name = :bicycle_cms
  config.parent_controller = '::BicycleCms::ApplicationController'
end

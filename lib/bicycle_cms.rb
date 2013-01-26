require 'active_support/all'
require 'rails'
require 'randexp'

require 'mini_record'
require 'default_value_for'
require 'squeel'
require 'active_enum'
require 'squeel'
require 'multiple_table_inheritance'

require 'inherited_resources'
require 'responders'
require 'draper'

require 'rails-i18n'

require 'haml'
require 'formtastic'
require 'nested_form'
require 'jquery-rails'

require 'friendly_id'
require 'devise'

require 'carrierwave'
require 'mini_magick'

require 'bicycle_cms/version'
require 'bicycle_cms/engine'

require 'bicycle_cms/erb_sandbox'
require 'bicycle_cms/page_vars'
require 'bicycle_cms/roler'
require 'bicycle_cms/default_scopes'
require 'bicycle_cms/mail_interceptor'
require 'panel_link_action'
require 'bicycle_cms/renderer'
require 'bicycle_cms/panels'
require 'bicycle_cms/captcha'

module BicycleCms

=begin
    # FIXME
    config.session_store :active_record_store
    config.active_record.timestamped_migrations = false
    config.active_record.whitelist_attributes = true
    config.active_record.mass_assignment_sanitizer = :strict
    config.cache_store = :memory_store
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.precompile += %w(*)
=end

  mattr_accessor :admin_email
  @@admin_email = 'email@example.com'

  mattr_accessor :admin_name
  @@admin_name = 'Administrator'

  mattr_accessor :hostname
  @@hostname = 'example.com'

  mattr_accessor :global_description
  @@global_description = 'Site description'

  mattr_accessor :global_keywords
  @@global_keywords = ''

  mattr_accessor :global_title
  @@global_title = 'Site Title'

  mattr_accessor :number_of_prebuild_attachments
  @@number_of_prebuild_attachments = 5

  mattr_accessor :root_route
  @@root_route = [ { :to => 'articles#show', :id => 1 } ]

  mattr_accessor :pepper
  @@pepper = 'FIXME'

end

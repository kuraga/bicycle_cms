require 'active_support/all'
require 'rails'
require 'configatron'

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

require 'captchator'

require 'bicycle_cms/version'
require 'bicycle_cms/engine'

require 'bicycle_cms/erb_sandbox'
require 'bicycle_cms/page_vars'
require 'bicycle_cms/roler'
require 'bicycle_cms/default_scopes'
require 'bicycle_cms/mail_interceptor'
require 'bicycle_cms/renderer'
require 'bicycle_cms/panels'
require 'panel_link_action'

module BicycleCms

  mattr_accessor :admin_email
  @@admin_email = 'email@example.com'

  mattr_accessor :admin_name
  @@admin_name = 'Administrator'

  mattr_accessor :hostname
  @@hostname = 'http://example.com'

  mattr_accessor :global_description
  @@global_description = 'Site description'

  mattr_accessor :global_keywords
  @@global_keywords = ''

  mattr_accessor :global_title
  @@global_title = 'Site Title'


  mattr_accessor :number_of_prebuild_attachments
  @@number_of_prebuild_attachments = 5

end

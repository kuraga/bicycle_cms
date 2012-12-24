require 'bicycle_cms/page_vars'
require 'bicycle_cms/authenticater'
require 'bicycle_cms/roler'
require 'bicycle_cms/renderer'
require 'bicycle_cms/panels'
require 'bicycle_cms/erb_sandbox'

module BicycleCms
  module ApplicationHelper

    def method_missing method, *args, &block
      super unless method.to_s.end_with?('_path') or method.to_s.end_with?('_url')

      main_app.respond_to?(method) ? main_app.send(method, *args) : super
    end
 
    def respond_to?(method)
      super unless method.to_s.end_with?('_path') or method.to_s.end_with?('_url')

      main_app.respond_to?(method) ? true : super
    end

    include ::ApplicationHelper
#XYZ    include Rails.application.routes.url_helpers
    include Authenticater
    include Roler
    include Renderer
    include ErbSandbox
    include Panels

    def name_with_email name, email = nil, make_links = true
      ("#{name}" + (email.not_nil? ? " (#{make_links ? mail_to(email) : email})" : '')).html_safe
    end

  end
end

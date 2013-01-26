module BicycleCms
  module ApplicationHelper

    # TODO Подумать
    def method_missing method, *args, &block
      return super unless method.to_s.end_with?('_path') or method.to_s.end_with?('_url')

      main_app.respond_to?(method) ? main_app.send(method, *args, &block) : super
    end
 
    def respond_to? method, *args
      return super unless method.to_s.end_with?('_path') or method.to_s.end_with?('_url')

      main_app.respond_to?(method, *args) ? true : super
    end

    # TODO Разбить на подхелперы

    include ::ApplicationHelper
    include Roler
    include Renderer
    include ErbSandbox
    include Panels
    include Captcha::Helper

    def current_user
      super.decorate
    end

    def name_with_email name, email = nil, make_links = true
      ( "#{name}" + (email.not_nil? ? " (#{make_links ? mail_to(email) : email})" : '') ).html_safe
    end

    def current_order
      session[:order] ||= Order.new
    end

  end
end

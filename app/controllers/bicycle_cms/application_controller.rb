require 'bicycle_cms/redirector'
require 'bicycle_cms/authenticater'
require 'bicycle_cms/roler'

module BicycleCms
  class ApplicationController < ::ApplicationController

    inherit_resources

    include Redirector
    include Authenticater
    include RenderCallbacks
    include Roler

    # TODO Избавиться
    def self.inherited(subclass)
      super
      subclass.send :include, BicycleCms::PageVars
    end

    responders :flash
    layout proc { |c| c.request.xhr? ? false : 'site' }
    helper :all

    add_breadcrumb I18n.t('application.main.main_article'), :root_path

    protected

    def title_action_name 
      case action_name
        when /create/ then 'new'
        when /update/ then 'edit'
        else action_name
      end
    end

    def self.page_vars page_vars_hash = {}
      before_render_filter do
        [:title, :keywords, :description, :breadcrumbs].each do |page_var_name|
          send "page_vars_add_#{page_var_name}", page_vars_hash[page_var_name] if page_vars_hash.has_key? page_var_name
          # RAILS4 Условие можно заменить на try
          send "page_vars_add_#{page_var_name}", resource.send(page_var_name) if params[:id] and resource.respond_to?(page_var_name) and resource.send(page_var_name).present?
        end # TODO Как определить, есть ли resource?
        page_vars_add_breadcrumb title: t("#{resource_class.model_name.to_s.underscore.pluralize}.actions.#{title_action_name}"), path: polymorphic_path((title_action_name !~ /new/ ? resource : resource_class), action: title_action_name) unless title_action_name =~ /index|show|destroy/
        page_vars_add_title t("#{resource_class.model_name.to_s.underscore.pluralize}.actions.#{title_action_name}") if title_action_name =~ /new|create|edit|update|destroy/
      end
    end

    protected
      # TODO Перенести

      def resource
        get_resource_ivar || begin
          resource_local = end_of_association_chain.send(method_for_find, params[:id])
          resource_local.decorate; set_resource_ivar(begin; resource_local.decorate; rescue NameError; resource_local; end)
        end
      end

      def build_resource
        get_resource_ivar || begin
          resource_local = end_of_association_chain.send(method_for_build, *resource_params)
          set_resource_ivar(begin; resource_local.decorate; rescue NameError; resource_local; end)
        end
      end

      def collection
        get_collection_ivar || begin
          c = end_of_association_chain
          collection_local = c.respond_to?(:scoped) ? c.scoped : c.all
          set_collection_ivar(begin; collection_local.decorate; rescue NameError; collection_local; end)
        end
      end

      def update_resource(object, attributes)
        attributes[1] ||= {}
        attributes[1][:as] ||= current_user_role_for(action_name =~ /new|create/ ? build_resource : resource) if params[:id] # TODO Как определить, есть ли resource?

        super
      end

  end
end

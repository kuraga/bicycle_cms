module BicycleCms
  class ApplicationController < ::ApplicationController

    include RenderCallbacks
    include Roler
    include PageVars
    include Captcha::Controller

    responders :flash
    layout proc { |c| c.request.xhr? ? false : 'site' }
    helper :all

    page_vars_add_description BicycleCms.global_description
    page_vars_add_keywords    BicycleCms.global_keywords
    page_vars_add_title       BicycleCms.global_title
    page_vars_add_breadcrumbs PageVars::Breadcrumb[title: I18n.t('application.main.main_article'), path: :root_path]

    protected

      # TODO
      before_filter do
        self.class.before_render_filter do
          set_resource_ivar(begin; get_resource_ivar.decorate; rescue NameError; get_resource_ivar; end) if get_resource_ivar
          set_collection_ivar(begin; get_collection_ivar.decorate; rescue NameError; get_collection_ivar; end) if get_collection_ivar
        end
      end

    protected

      def title_action_name 
        case action_name
        when /create/ then 'new'
        when /update/ then 'edit'
        else action_name
        end
      end

      def self.page_vars page_vars_hash = {}
        options = page_vars_hash.slice(:only, :except)
        before_render_filter options do
          [:title, :keywords, :description, :breadcrumbs].each do |page_var_name|
            send "page_vars_add_#{page_var_name}", *Array.wrap(page_vars_hash[page_var_name]) if page_vars_hash.has_key? page_var_name
            # RAILS4 Условие можно заменить на try
            send "page_vars_add_#{page_var_name}", *Array.wrap(resource.send(page_var_name)) if params[:id] and resource.respond_to?(page_var_name) and resource.send(page_var_name).present?
          end # TODO Как определить, есть ли resource?
          page_vars_add_breadcrumbs PageVars::Breadcrumb[title: t("#{resource_class.model_name.to_s.underscore.pluralize}.actions.#{title_action_name}"), path: polymorphic_path((title_action_name !~ /new/ ? resource : resource_class), action: title_action_name)] unless title_action_name =~ /index|show|destroy/
          page_vars_add_title t("#{resource_class.model_name.to_s.underscore.pluralize}.actions.#{title_action_name}") if title_action_name =~ /new|create|edit|update|destroy/
        end
      end

    protected

      # TODO Перенести и обдумать
      def self.inherited subclass
        super
        subclass.class_eval do

          def role_given?
            true
          end

          def as_role
            { :as => current_user_role_for(params[:id] ? resource : nil) || self.resources_configuration[:self][:role] || :default }.tap {|x|p x}
          end

        end
      end

  end
end

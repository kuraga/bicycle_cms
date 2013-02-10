module BicycleCms
  module Panels
    
    # TODO Выбор возвращаемых параметров (only-except)
    def self.define_default_action_links_for(object_class_name, actions = [:new, :edit, :destroy])
      actions.each do |action|
        case action
        when /new|edit/
          define_method "#{action}_#{object_class_name}_link" do |object, options, wrapper_html_options|
            link_to t("#{object_class_name.to_s.pluralize}.actions_short.#{action}"), polymorphic_path(object, action: action), (options || {}).reverse_merge(rel: :nofollow).merge(wrapper_html_options || {})
          end
        when /destroy/
          define_method "destroy_#{object_class_name}_link" do |object, options, wrapper_html_options|
            link_to t("#{object_class_name.to_s.pluralize}.actions_short.destroy"), object, (options || {}).reverse_merge(method: :delete, data: { confirm: t('general.messages.are_you_sure?') }, rel: :nofollow).merge(wrapper_html_options || {})
          end
        else
          '' # TODO raise
        end
      end
    end

    def render_panel_for(object, options = {}, &block)
      capabilities = options.delete(:capabilities) || []
      locals = options.delete(:locals) || {}

      content_tag :span, class: (block_given? ? :actions_with_sign : :actions_without_sign) do
        capture do
          yield object if block_given?
          concat ( content_tag :span, class: :actions do
            ext_render options.reverse_merge(object: object, partial: 'panel', locals: locals.reverse_merge(capabilities: capabilities))
          end )
        end
      end
    rescue ActionView::MissingTemplate
    end

    extend ActiveSupport::Autoload

    # TODO Автоматизировать include
    autoload :ArticlePanel
    autoload :EventPanel
    autoload :CommentPanel
    autoload :CategoryPanel
    autoload :UserPanel
    autoload :FeedbackPanel
    autoload :MailingPanel

  end
end

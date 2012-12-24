module BicycleCms
  module Panels
    
    # TODO Выбор возвращаемых параметров (only-except)
    def self.define_default_action_links_for object_class_name, actions = [:new, :edit, :destroy]
      actions.each do |action|
        case action
        when /new|edit/
    define_method "#{action}_#{object_class_name}_link" do |object|
      link_to t("#{object_class_name.to_s.pluralize}.actions_short.#{action}"), polymorphic_path(object, action: action), rel: :nofollow
    end
        when /destroy/
    define_method "destroy_#{object_class_name}_link" do |object|
      link_to t("#{object_class_name.to_s.pluralize}.actions_short.destroy"), object, method: :delete, data: { confirm: t('general.messages.are_you_sure?') }, rel: :nofollow
    end
        else
    # TODO raise
    ""
        end
      end
    end

    def render_panel_for object, options = {}, &block
      capabilities = options.delete(:capabilities) || []
      as = options.delete(:as)

      content_tag :span, class: (block_given? ? :actions_with_sign : :actions_without_sign) do
        begin
          capture do
            yield object if block_given?
            concat ( content_tag :span, class: :actions do
              ext_render object, view: :panel, as: as, locals: options
            end )
          end
        rescue ActionView::MissingTemplate
          capture do
            yield object if block_given?
            if capabilities.present?
              concat ( semantic_form_for object do |form|
                # TODO Почему приходится использовать фигурные скобки?
                form.actions {
                  capabilities.each { |capability|
                    concat ( form.action capability, as: :panel_link )
                  }
                }
              end )
            end
          end
        end
      end
    end

    extend ActiveSupport::Autoload

    # TODO Автоматизировать include
    autoload :ArticlePanel
    autoload :EventPanel
    autoload :CommentPanel
    autoload :CategoryPanel
    autoload :UserPanel
    autoload :FeedbackPanel
    autoload :FeedbackReplyPanel
    autoload :MailingPanel
    autoload :ProductPanel

  end
end

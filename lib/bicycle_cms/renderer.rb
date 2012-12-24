module BicycleCms
  module Renderer
    # TODO options должен подразумевать передачу различных опций вызываемым функциям
    # TODO options & locals
    # TODO нужно ли что-то делать, если нет соответствующего partial'а?

    include Roler

    def ext_render object, options = {}, &block
      object_model_names = Array.wrap(options.delete(:class_names) || object.model_class.ancestors.select { |klass| klass.is_a? Class }.take_while { |klass| ActiveRecord::Base != klass }.map { |ancestor| ancestor.model_name.to_s })
      as = options.delete(:as) || object.class.model_name.to_s.demodulize.underscore
      role = options.delete(:role) || current_user_role_for(object) 
      action = options.delete(:action) || ''
      view = options.delete(:view) || ''
      locals = options.delete(:locals) || {}

      partials = (object_model_names.map do |object_model_name|
        [
        object_model_name.underscore.presense('') { "#{object_model_name.underscore.pluralize}/" } + action.presense('') { "#{action}_" } + view.presense('') { "#{view}" } + role.presense('') { "_#{role}" },
        object_model_name.underscore.presense('') { "#{object_model_name.underscore.pluralize}/" } + action.presense('') { "#{action}_" } + view.presense('') { "#{view}" },
        object_model_name.underscore.presense('') { "#{object_model_name.underscore.pluralize}/" } + view.presense('') { "#{view}" } + role.presense('') { "_#{role}" },
        object_model_name.underscore.presense('') { "#{object_model_name.underscore.pluralize}/" } + view.presense('') { "#{view}" },
        ]
      end.flatten +
        [
        action.presense('') { "#{action}_" } + view.presense('') { "#{view}" } + role.presense('') { "_#{role}" },
        action.presense('') { "#{action}_" } + view.presense('') { "#{view}" },
        view.presense('') { "#{view}" } + role.presense('') { "_#{role}" },
        view.presense('') { "#{view}" }
        ]
      ).uniq

      capture do
        yield object if block_given?
        concat ( render partial: partials, object: object, as: as, locals: locals )
      end
    end

    def render_form_for object, options = {}, &block
      action = options.delete(:action) || ''
      locals = options.delete(:locals) || {}

      begin
        capture do
          concat ( ext_render object, options.merge({view: 'form', action: action}), &block )
        end
      rescue ActionView::MissingTemplate
        # XYZ Не работает
        capture do
          yield object if block_given?
          concat ( semantic_form_for object, options do |form|
            concat ( form.inputs *object.class.accessible_attributes.to_a )
            concat ( form.actions )
          end )
        end
      end
    end

    def render_fields_for form, options = {}, &block
      object_model_name = form.object.class.model_name.to_s
      action = options.delete(:action) || ''
      parent = options.delete(:parent)
      role = options.delete(:role) || current_user_role_for(parent)
      locals = options.delete(:locals) || {}

      begin
        capture do
          ext_render form, class_names: object_model_name.underscore, view: 'fields', role: role, action: action, as: "#{object_model_name.demodulize.underscore}_form", locals: locals
        end
      rescue ActionView::MissingTemplate
        # XYZ Не работает
        capture do
          yield object if block_given?
          concat ( semantic_form_for form.object.class.to_s.pluralize.to_sym, options do |fields|
            concat ( fields.inputs *form.object.model_name.class.accessible_attributes.to_a )
          end )
        end
      end
    end

    def render_properties_for object, properties = object.properties, options = {}
      object_model_name = object.class.model_name.to_s
      role = options.delete(:role) || current_user_role_for(object)
      locals = options.delete(:locals) || {}

      ext_render properties, class_names: object_model_name.underscore, view: 'properties', role: role, as: :properties, locals: locals
    end

    def render_spoiler more_phrase = t('application.general.more'), &block
      content_tag :div, class: :spoiler_wrapper do
        concat ( link_to_function more_phrase, "$(this).next('.spoiler').toggle()" )
        concat ( content_tag :div, class: :spoiler, style: 'display: none;' do
          yield
        end )
      end
    end

    def link_with_contenttype_icon attachment
      # TODO Случай отсутствия slug
      # XYZ иконка одна и та же
      link_to(image_tag('mimes/application-pdf.png', class: 'mime_icon_small')+attachment.slug.presense(attachment.file), attachment.file.url).html_safe
    end

    # XYZ
    def render_admin_block options = {}
      locals = options.delete(:locals) || {}
      render partial: 'admin_actions', locals: locals if signed_in_as_admin?
    end

  end
end

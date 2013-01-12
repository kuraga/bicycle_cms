module BicycleCms
  module Renderer
    # TODO options должен подразумевать передачу различных опций вызываемым функциям
    # TODO options & locals
    # TODO нужно ли что-то делать, если нет соответствующего partial'а?

    include Roler

    def ext_render object, options = {}, &block
      object_model_names = Array.wrap( options.delete(:class_names) || (object.model_class.ancestors.select { |klass| klass.is_a? Class }.take_while { |klass| ActiveRecord::Base != klass }.map { |ancestor| ancestor.model_name } if object) ).map(&:to_s).map(&:underscore).map(&:pluralize)
      as = options.delete(:as) || (object.class.model_name.to_s.demodulize.underscore if object)
      role = options.delete(:role) || (current_user_role_for(object, owner: options.delete(:owner), roles: options.delete(:roles)) if object)
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
        concat ( yield object ) if block_given?
        concat ( 
          if object and as
            render partial: partials, object: object, as: as, locals: locals
          else
            render partial: partials, locals: locals
          end
        )
      end
    end

    def render_form_for object, options = {}, &block
      capture do
        concat ( yield object ) if block_given?
        concat ( ext_render object, options.merge(view: 'form'), &block )
      end
    end

    def render_fields_for form, options = {}, &block
      object_model_name = form.object.class.model_name.to_s
      role = options.delete(:role) || current_user_role_for(parent)

      capture do
        concat ( yield object ) if block_given?
        concat ( ext_render form, options.merge(class_names: object_model_name.underscore, view: 'fields', as: "#{object_model_name.demodulize.underscore}_form") )
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

    # TODO Избавиться
    def link_with_contenttype_icon attachment
      # TODO Случай отсутствия slug
      # XYZ иконка одна и та же
      link_to(image_tag('mimes/application-pdf.png', class: 'mime_icon_small')+attachment.slug.presense(attachment.file), attachment.file.url).html_safe
    end

    def render_user_block options = {}
      locals = options.delete(:locals) || {}
      render partial: 'user_block', locals: locals
    end

  end
end

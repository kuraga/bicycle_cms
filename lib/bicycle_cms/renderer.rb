module BicycleCms
  module Renderer

    include Roler

    # TODO Привести прототип к Rails-форме
    def ext_render(options = {}, &block)
      action = options.delete(:action)
      path = options.delete(:path)
      role = options.delete(:role) || current_user_role
      options[:prefixes] = lambda do |prefixes|
        prefixes.map do |prefix|
          res = [ prefix ]
          res << prefix = path if path
          res << "#{role}/#{prefix}/#{action}" if role && action
          res << "#{prefix}/#{action}" if action
          res << "#{role}/#{prefix}" if role
          res
        end.flatten
      end

      render options, &block
    end

    def render_form_for(object, options = {}, &block)
      ext_render options.reverse_merge(path: object.class.model_name.to_s.tableize, partial: 'form', object: object, as: object.class.model_name.to_s.demodulize.underscore), &block
    end

    def render_fields_for(form, options = {}, &block)
      ext_render options.reverse_merge(path: form.object.class.model_name.to_s.tableize, partial: 'fields', object: form, as: :"#{form.object.class.model_name.to_s.demodulize.underscore}_form"), &block
    end

    def render_properties_for(object, properties = object.properties, options = {}, &block)
      ext_render options.reverse_merge(path: object.class.model_name.to_s.tableize, partial: 'properties', object: properties, as: :properties), &block
    end

    def render_breadcrumbs(breadcrumbs)
      render partial: 'breadcrumbs', object: breadcrumbs, as: :breadcrumbs
    end

    def render_spoiler(more_phrase = t('application.general.more'), &block)
      content_tag :div, class: :spoiler_wrapper do
        concat ( link_to_function more_phrase, "$(this).next('.spoiler').toggle();" )
        concat ( content_tag :div, class: :spoiler, style: 'display: none;', &block )
      end
    end

    def render_user_block(options = {})
      ext_render options.reverse_merge(partial: 'user_block')
    end

  end
end

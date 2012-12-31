require 'breadcrumbs_on_rails'

module BreadcrumbsOnRails
  module Breadcrumbs

    class ListBuilder < Builder

      def render
        @context.capture do
          @context.content_tag :ul, {:class => 'path'} || @options[:ul_options] do
            @elements.collect do |element|
              @context.concat ( @context.content_tag(:li, {:class => 'path_element'} || @options[:li_options]) { render_element(element) } )
            end
          end
        end
      end

      def render_element(element)
        @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end

    end

  end
end

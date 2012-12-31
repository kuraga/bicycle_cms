require 'formtastic'

module Formtastic
  module Inputs

    class UneditableInput 

      include Base

      def to_html
        input_wrapping do
          label_html <<
          template.content_tag(:span, input_html_options) { block_given? ? yield : (options[:value] || builder.object.send(method)) }
        end
      end
      
      def error_html
        ""
      end
      
      def errors?
        false
      end
      
      def wrapper_html_options
        new_class = [super[:class], "uneditable"].compact.join(" ")
        super.merge(:class => new_class)
      end

    end

  end
end

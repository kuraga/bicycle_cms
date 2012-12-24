class Object

  def not_nil?
    not self.nil?
  end

  def presense default = nil, &block
    if present? 
      block_given? ? yield(self) : self
    else
      default
    end
  end

end


class Array

  def extract_options_by_keys! *keys
    options = self.extract_options!
    options.extract! keys if keys
    self.push options
    options
  end

end


module ActiveModel
  module MassAssignmentSecurity

    module ClassMethods

      def remove_attr_accessible *args
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || role

        attr_accessible *(accessible_attributes(source_role).to_a - args), role: role
      end

      def add_attr_accessible *args
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || :default

        attr_accessible *(accessible_attributes(source_role).to_a + args), role: role
      end

    end

  end
end


#XYZ
module ActionMailer
  class Base

    def self.email_with_name email, name
      "#{name} <#{email}>".html_safe
    end

  end
end


module ActionView
  class Renderer

    alias_method :render_original, :render
    def render(context, options)
      if options.key?(:partial)
        err = nil
        Array.wrap(options[:partial]).each do |partial|
          begin
            return render_original(context, options.merge({:partial => partial}))
          rescue ActionView::MissingTemplate => e
            err = e
          end
        end
        raise err # XYZ Не работает
      else
        return render_template(context, options)
      end
    end

  end
end


module ActionView
  class PartialRenderer

    def setup_with_wrapper_option(context, options, block)
      # TODO При тако походе prefix префиксует к имени каталога, а не файла (необходимо модифицировать to_partial_path)
      # TODO postfix, prefix могут быть Array[String]

      res = setup_without_wrapper_option(context, options, block)
      return res unless @path

      # prefix = options.delete(:prefix) || options[:locals].try(:delete, :prefix)
      postfix = options.delete(:postfix) || options[:locals].try(:delete, :postfix)
      # @path = "#{prefix}_#{@path}" if prefix
      @path = "#{@path}_#{postfix}" if postfix

      res
    end

    alias_method_chain :setup, :wrapper_option

  end
end


module BreadcrumbsOnRails
  module ActionController

    def add_breadcrumbs(breadcrumbs)
      breadcrumbs.each { |breadcrumb| add_breadcrumb(breadcrumb) }
    end

  end
end


module ActiveRecord
  class Base

    def model_class
      self.class
    end

  end
end

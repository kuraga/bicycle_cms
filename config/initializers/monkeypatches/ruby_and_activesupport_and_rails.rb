# TODO require

module Kernel

  def callable_from_handler(handler)
    case handler
    when String
      -> { handler }
    when Symbol
      method)handler)
    else
      handler
    end
  end

end


class Object

  def not_nil?
    not self.nil?
  end

  def presense(default=nil, &block)
    if present? 
      block_given? ? yield(self) : self
    else
      default
    end
  end

end


class Array

  def extract_options_by_keys!(*keys)
    options = self.extract_options!
    options.extract!(keys) if keys
    self.push(options)
    options
  end

end


module ActiveModel
  module MassAssignmentSecurity

    module ClassMethods

      def remove_attr_accessible(*args)
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || role

        attr_accessible(*(accessible_attributes(source_role).to_a - args), :role => role)
      end

      def add_attr_accessible(*args)
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || :default

        attr_accessible(*(accessible_attributes(source_role).to_a + args), :role => role)
      end

    end

  end
end


# FIXME Избавиться
module ActionMailer
  class Base

    def self.email_with_name(email, name)
      "#{name} <#{email}>".html_safe
    end

  end
end


module ActionView
  class Renderer

    def render_with_multiple_partials(context, options)
      if options.key?(:partial)
        err = nil
        Array.wrap(options[:partial]).each do |partial|
          begin
            return render_without_multiple_partials(context, options.merge({:partial => partial}))
          rescue ActionView::MissingTemplate => e
            err = e
          end
        end
        raise err # FIXME Не работает
      else
        return render_template(context, options)
      end
    end

    alias_method_chain :render, :multiple_partials

  end
end


module ActionView
  class PartialRenderer

    def find_template(path=@path, locals=@locals.keys)
      @prefixes
      prefixes = if @prefixes
        @prefixes
      else
        path.include?(?/) ? [] : @lookup_context.prefixes
      end
      @lookup_context.find_template(path, prefixes, true, locals, @details)
    end

    def render_with_prefixes_option(context, options, block)
      if options.key?(:prefixes)
        @prefixes = @prefixes.try(:clone).tap do
          @prefixes = options[:prefixes].call(@lookup_context.prefixes.dup)
          res = render_without_prefixes_option(context, options, block)
        end
        res
      else
        render_without_prefixes_option(context, options, block)
      end
    end

    alias_method_chain :render, :prefixes_option

  end
end


module ActionView
  class PartialRenderer

    def setup(context, options, block)
      @view   = context
      partial = options[:partial]
      postfix = options[:postfix] ? Array.wrap(postfix).join('_') : nil

      @options = options
      @locals  = options[:locals] || {}
      @block   = block
      @details = extract_details(options)

      if String === partial
        @object     = options[:object]
        @path       = partial
        @collection = collection
      else
        @object = partial

        if @collection = collection_from_object || collection
          paths = @collection_data = @collection.map { |o| Proc === partial ? partial(@object) : partial_path(o) }
          @path = paths.uniq.size == 1 ? paths.first : nil
        else
          @path = Proc === partial ? partial(@object) : partial_path
        end
      end

      if @path
        @variable, @variable_counter = retrieve_variable(postfix ? "#{@path}_#{postfix}" : @path)
      else
        paths.map! { |path| retrieve_variable(path).unshift(postfix ? "#{path}_#{postfix}" : path) }
      end

      if String === partial && @variable.to_s !~ /^[a-z_][a-zA-Z_0-9]*$/
        raise ArgumentError.new("The partial name (#{partial}) is not a valid Ruby identifier; " +
                                "make sure your partial name starts with a letter or underscore, " +
                                "and is followed by any combinations of letters, numbers, or underscores.")
      end

      extract_format(@path, @details)
      self
    end

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

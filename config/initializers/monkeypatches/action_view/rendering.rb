module ActionView
  class PartialRenderer

    def find_template(path=@path, locals=@locals.keys)
      prefixes = path.include?(?/) ? [] : (@prefixes ? @prefixes : @lookup_context.prefixes)
      @lookup_context.find_template(path, prefixes, true, locals, @details)
    end

    def render_with_prefixes_option(context, options, block)
      if options.key?(:prefixes)
        @prefixes = @prefixes.try(:clone).tap do
          @prefixes = options[:prefixes].call(@lookup_context.prefixes.dup)
          return render_without_prefixes_option(context, options, block)
        end
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

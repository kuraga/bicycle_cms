module RenderCallbacks
    extend ActiveSupport::Concern

    include ActiveSupport::Callbacks

    included do
      alias_method_chain :render, :render_callbacks
      define_callbacks :proccess_render
    end

    def render_with_render_callbacks(*options, &blk)
      run_callbacks(:proccess_render, action_name) do
        render_without_render_callbacks(*options, &blk)
      end
    end

    module ClassMethods
      # If :only or :except are used, convert the options into the
      # primitive form (:per_key) used by ActiveSupport::Callbacks.
      # The basic idea is that :only => :index gets converted to
      # :if => proc {|c| c.action_name == "index" }, but that the
      # proc is only evaluated once per action for the lifetime of
      # a Rails process.
      #
      # ==== Options
      # * <tt>only</tt> - The callback should be run only for this action
      # * <tt>except</tt> - The callback should be run for all actions except this action
      def _normalize_callback_options(options)
        if only = options[:only]
          only = Array(only).map {|o| "action_name == '#{o}'"}.join(" || ")
          options[:per_key] = {:if => only}
        end
        if except = options[:except]
          except = Array(except).map {|e| "action_name == '#{e}'"}.join(" || ")
          options[:per_key] = {:unless => except}
        end
      end

      # Skip before, after, and around render filters matching any of the names
      #
      # ==== Parameters
      # * <tt>names</tt> - A list of valid names that could be used for
      # callbacks. Note that skipping uses Ruby equality, so it's
      # impossible to skip a callback defined using an anonymous proc
      # using #skip_filter
      def skip_filter(*names, &blk)
        skip_before_render_filter(*names)
        skip_after_render_filter(*names)
        skip_around_render_filter(*names)
      end

      # Take callback names and an optional callback proc, normalize them,
      # then call the block with each callback. This allows us to abstract
      # the normalization across several methods that use it.
      #
      # ==== Parameters
      # * <tt>callbacks</tt> - An array of callbacks, with an optional
      # options hash as the last parameter.
      # * <tt>block</tt> - A proc that should be added to the callbacks.
      #
      # ==== Block Parameters
      # * <tt>name</tt> - The callback to be added
      # * <tt>options</tt> - A hash of options to be used when adding the callback
      def _insert_callbacks(callbacks, block)
        options = callbacks.last.is_a?(Hash) ? callbacks.pop : {}
        _normalize_callback_options(options)
        callbacks.push(block) if block
        callbacks.each do |callback|
          yield callback, options
        end
      end

      ##
      # :method: before_render_filter
      #
      # :call-seq: before_render_filter(names, block)
      #
      # Append a before render filter. See _insert_callbacks for parameter details.

      ##
      # :method: prepend_before_render_filter
      #
      # :call-seq: prepend_before_render_filter(names, block)
      #
      # Prepend a before render filter. See _insert_callbacks for parameter details.

      ##
      # :method: skip_before_render_filter
      #
      # :call-seq: skip_before_render_filter(names, block)
      #
      # Skip a before render filter. See _insert_callbacks for parameter details.

      ##
      # :method: append_before_render_filter
      #
      # :call-seq: append_before_render_filter(names, block)
      #
      # Append a before render filter. See _insert_callbacks for parameter details.

      ##
      # :method: after_render_filter
      #
      # :call-seq: after_render_filter(names, block)
      #
      # Append an after render filter. See _insert_callbacks for parameter details.

      ##
      # :method: prepend_after_render_filter
      #
      # :call-seq: prepend_after_render_filter(names, block)
      #
      # Prepend an after render filter. See _insert_callbacks for parameter details.

      ##
      # :method: skip_after_render_filter
      #
      # :call-seq: skip_after_render_filter(names, block)
      #
      # Skip an after render filter. See _insert_callbacks for parameter details.

      ##
      # :method: append_after_render_filter
      #
      # :call-seq: append_after_render_filter(names, block)
      #
      # Append an after render filter. See _insert_callbacks for parameter details.

      ##
      # :method: around_render_filter
      #
      # :call-seq: around_render_filter(names, block)
      #
      # Append an around render filter. See _insert_callbacks for parameter details.

      ##
      # :method: prepend_around_render_filter
      #
      # :call-seq: prepend_around_render_filter(names, block)
      #
      # Prepend an around render filter. See _insert_callbacks for parameter details.

      ##
      # :method: skip_around_render_filter
      #
      # :call-seq: skip_around_render_filter(names, block)
      #
      # Skip an around render filter. See _insert_callbacks for parameter details.

      ##
      # :method: append_around_render_filter
      #
      # :call-seq: append_around_render_filter(names, block)
      #
      # Append an around render filter. See _insert_callbacks for parameter details.

      # set up before_render_filter, prepend_before_render_filter, skip_before_render_filter, etc.
      # for each of before, after, and around.
      # set up before_render_filter, prepend_before_render_filter, skip_before_render_filter, etc.
      # for each of before, after, and around.
      [:before, :after, :around].each do |filter|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          # Append a before, after or around render filter. See _insert_callbacks
          # for details on the allowed parameters.
          def #{filter}_render_filter(*names, &blk)                                          # def before_render_filter(*names, &blk)
            _insert_callbacks(names, blk) do |name, options|                                 #   _insert_callbacks(names, blk) do |name, options|
              options[:if] = (Array.wrap(options[:if]) << "!halted") if #{filter == :after}  #     options[:if] = (Array.wrap(options[:if]) << "!halted") if false
              set_callback(:proccess_render, :#{filter}, name, options)                      #     set_callback(:proccess_render, :before, name, options)
            end                                                                              #   end
          end                                                                                # end

          # Prepend a before, after or around render filter. See _insert_callbacks
          # for details on the allowed parameters.
          def prepend_#{filter}_render_filter(*names, &blk)                                     # def prepend_before_render_filter(*names, &blk)
            _insert_callbacks(names, blk) do |name, options|                                    #   _insert_callbacks(names, blk) do |name, options|
              options[:if] = (Array.wrap(options[:if]) << "!halted") if #{filter == :after}     #     options[:if] = (Array.wrap(options[:if]) << "!halted") if false
              set_callback(:proccess_render, :#{filter}, name, options.merge(:prepend => true)) #     set_callback(:proccess_render, :before, name, options.merge(:prepend => true))
            end                                                                                 #   end
          end                                                                                   # end

          # Skip a before, after or around render filter. See _insert_callbacks
          # for details on the allowed parameters.
          def skip_#{filter}_render_filter(*names, &blk)                 # def skip_before_render_filter(*names, &blk)
            _insert_callbacks(names, blk) do |name, options|             #   _insert_callbacks(names, blk) do |name, options|
              skip_callback(:proccess_render, :#{filter}, name, options) #     skip_callback(:proccess_render, :before, name, options)
            end                                                          #   end
          end                                                            # end

          # *render_filter is the same as append_*_render_filter
          alias_method :append_#{filter}_render_filter, :#{filter}_render_filter  # alias_method :append_before_render_filter, :before_render_filter
        RUBY_EVAL
      end
    end

end

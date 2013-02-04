# TODO require

module Kernel

  def callable_from_handler(handler)
    case handler
    when String
      lambda { handler }
    when Symbol
      method(handler)
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
  module Naming

    def self.model_class
      self.class
    end

  end
end

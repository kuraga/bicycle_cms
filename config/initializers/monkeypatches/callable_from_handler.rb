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

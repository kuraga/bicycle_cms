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

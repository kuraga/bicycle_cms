class Array

  def decorate
    collect(&:decorate)
  end

end

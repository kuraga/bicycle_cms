module ActiveModel
  module Validations

    def valid?(context = nil)
      current_context, self.validation_context = validation_context, context
      # don't errors.clear
      run_validations!
    ensure
      self.validation_context = current_context
    end

  end
end

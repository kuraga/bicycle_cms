require 'formtastic'

module Formtastic
  module LocalizedString

    def model_name
      @object.present? ? @object.class.model_name : @object_name.to_s.classify
    end

  end
end

module BicycleCms
  module PageVars
    class Property < Hash

      def initialize object, name, value = object.send(name)
        object_class_name_underscored = object.class.model_name.to_s.underscore
        self.merge! name: name, label: I18n.t("#{object_class_name_underscored.pluralize}.attributes.#{name}"), value: value
      end

      def to_partial_path
        'property'
      end

    end
  end
end

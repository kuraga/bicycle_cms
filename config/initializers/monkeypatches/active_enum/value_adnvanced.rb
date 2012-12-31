require 'active_enum'

module ActiveEnum
  class Base

    class << self
      def values *vals
        vals.each { |val| value val }
      end

      def value_id_as_name name
        value id: name, name: name
      end

      def values_id_as_name *vals
        vals.each { |val| value_id_as_name val }
      end

      def values_id_as_name_stringified *vals
        values_id_as_name *vals.map(&:to_s)
      end
    end

  end
end

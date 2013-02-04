module ActiveModel
  module MassAssignmentSecurity

    module ClassMethods

      def remove_attr_accessible(*args)
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || role

        attr_accessible(*(accessible_attributes(source_role).to_a - args), :role => role)
      end

      def add_attr_accessible(*args)
        options = args.extract_options!
        role = options[:as] || :default
        source_role = options[:source_as] || :default

        attr_accessible(*(accessible_attributes(source_role).to_a + args), :role => role)
      end

    end

  end
end

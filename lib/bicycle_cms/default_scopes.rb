module BicycleCms
  module DefaultScopes

    extend ActiveSupport::Concern

    module ClassMethods

      def define_default_scopes scope_attributes
        class_eval do

          attributes_cached = attribute_names.map(&:to_sym)
          scope_attributes.reverse_merge! is_active: :is_active, owner: :author, created_at: :published_at

          def self.actived;         where{ scope_attributes[:is_active] == true  }; end if attributes_cached.include? scope_attributes[:is_active]
          def self.owned_by(owner); where{ scope_attributes[:owner]     == owner }; end if attributes_cached.include? scope_attributes[:owner]
          begin
            def self.latest;                  order(scope_attributes[:created_at]).first;                   end
            def self.recent(period = 1.week); where{ scope_attributes[:created_at] > Time.current-period }; end
          end if attributes_cached.include? scope_attributes[:created_at]

        end
      end

    end

  end
end

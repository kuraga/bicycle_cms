module BicycleCms
  module PageVars
    class Breadcrumb < HashWithIndifferentAccess

      def initialize title, path
        super
        self.merge! title: title, path: path
      end

      def to_partial_path
        'breadcrumb'
      end

    end
  end
end

module BicycleCms
  class ApplicationDecorator < ::ApplicationDecorator

    include Draper::LazyHelpers

    delegate_all

=begin
    # TODO Разобраться (https://github.com/drapergem/draper/issues/66)
    def initialize input, context = {}
      throw 'Cannot decorate decorators' if input.is_a? ApplicationDecorator
      super
    end
=end

  end
end

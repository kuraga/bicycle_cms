module BicycleCms
  class ApplicationDecorator < ::ApplicationDecorator

    include Draper::LazyHelpers

    # TODO Разобраться (https://github.com/jcasimir/draper/issues/66)
    def initialize input, context = {}
      throw 'Cannot decorate decorators' if input.is_a? ApplicationDecorator
      super
    end

  end
end

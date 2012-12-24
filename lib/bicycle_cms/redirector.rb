module BicycleCms
  module Redirector
    # TODO Правильно ли мы обрабатываем ошибки?

    def forbidden!
      @title ||= t('general.messages.forbidden')
      flash[:alert] = t('general.messages.forbidden'); render 'shared/forbidden', status: :forbidden
    end

    def not_found!
      @title ||= t('general.messages.not_found')
      flash[:alert] = t('general.messages.not_found'); render 'shared/not_found', status: :not_found
    end

  end
end

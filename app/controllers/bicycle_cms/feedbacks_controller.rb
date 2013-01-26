module BicycleCms
  class FeedbacksController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: [:new, :create]

    before_filter(only: :create) { build_resource; get_resource_ivar.errors.add(:base, I18n.t('general.messages.captcha_error')) unless verify_captchator if params[:captchator_answer] }

    def create
      create! do |success, failure|
        success.any do
          redirect_to(@feedback.deliver ? root_path : new_feedback_path)
        end
      end
    end

  end
end

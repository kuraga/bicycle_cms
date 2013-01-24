module BicycleCms
  class CommentsController < ApplicationController

    respond_to :html, :js
    inherit_resources
    # FIXME belongs_to :article, polymorphic: true, parent_class: BicycleCms::Article # FIXME
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: :show

    before_filter(only: :create) { build_resource; get_resource_ivar.errors.add(:base, I18n.t('general.messages.captcha_error')) unless verify_captchator if params[:captchator_answer]  }

  end
end

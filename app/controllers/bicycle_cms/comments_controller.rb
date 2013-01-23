module BicycleCms
  class CommentsController < ApplicationController

    respond_to :html, :js
    inherit_resources
    belongs_to :article, polymorphic: true, parent_class: BicycleCms::Article # FIXME
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: :show

  end
end

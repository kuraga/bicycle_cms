module BicycleCms
  class CommentsController < ApplicationController

    respond_to :html, :js
    belongs_to :article, polymorphic: true
    actions :all
    page_vars

  end
end

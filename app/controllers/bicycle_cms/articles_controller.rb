module BicycleCms
  class ArticlesController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all, except: :index
    page_vars

    before_filter :authenticate_admin!, except: :show

    # TODO Избавиться
    before_render_filter(only: :show)         { @commentable = @article; @comment = @commentable.comments.build                }
    before_render_filter(only: [:new, :edit]) { BicycleCms.number_of_prebuild_attachments.times { resource.attachments.build } }

  end
end

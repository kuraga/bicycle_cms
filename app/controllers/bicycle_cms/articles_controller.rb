module BicycleCms
  class ArticlesController < ApplicationController

    respond_to :html
    actions :all, except: :index
    page_vars
    page_vars_depends_on :comments

    before_filter :authenticate_user!, except: :show

    # TODO Избавиться
    before_render_filter({ only: :show          }) { @commentable = @article; @comment = @commentable.comments.build }
    before_render_filter({ only: [:new, :edit]  }) { 5.times { resource.attachments.build } }

  end
end

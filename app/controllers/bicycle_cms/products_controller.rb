module BicycleCms
  class ProductsController < ApplicationController

    respond_to :html
    actions :all, except: :index
    page_vars

    before_filter :authenticate_user!, except: [:show, :calculate]

    # TODO Избавиться
    before_render_filter({ only: :show }) { @commentable = @product; @comment = @commentable.comments.build }
    before_render_filter({ only: :new  }) { build_resource.type='Product'; 5.times { build_resource.attachments.build } }
    before_render_filter({ only: :edit }) { 5.times { resource.attachments.build } }

  end
end

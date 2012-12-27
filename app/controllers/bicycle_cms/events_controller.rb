module BicycleCms
  class EventsController < ApplicationController

    respond_to :html
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: [:index, :show]

    # TODO Избавиться
    before_render_filter(only: :show        ) { @commentable = @event; @comment = @commentable.comments.build }
    before_render_filter(only: [:new, :edit]) { 5.times { resource.attachments.build } }

  end
end

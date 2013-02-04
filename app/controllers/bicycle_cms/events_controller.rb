module BicycleCms
  class EventsController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: [:index, :show]

    # TODO Избавиться
    before_render_filter(only: :show        ) { @commentable = @event; @comment = @commentable.comments.build                  }
    before_render_filter(only: [:new, :edit]) { self.class.number_of_prebuild_attachments.times { resource.attachments.build } }

  end
end

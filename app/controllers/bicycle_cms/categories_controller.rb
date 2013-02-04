module BicycleCms
  class CategoriesController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all, except: :index
    custom_actions resource: :tree
    page_vars

    before_filter :authenticate_admin!, except: [:show, :tree]

    # TODO Избавиться
    before_render_filter(only: [:new, :edit]) { self.class.number_of_prebuild_attachments.times { resource.attachments.build } }

    # FIXME tree

  end
end

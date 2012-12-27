module BicycleCms
  class UsersController < ApplicationController

    respond_to :html
    actions :all, except: :new
    page_vars except: [:profile, :edit_profile, :update_profile]

    before_filter :authenticate_admin!, except: [:index, :show, :new, :create]
    before_filter :authenticate_user!, excaept: :show

    # TODO Избавиться
    before_render_filter({ only: :edit }) { resource.build_profile unless resource.profile }

  end
end

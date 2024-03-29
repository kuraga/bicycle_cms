module BicycleCms
  class UsersController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all, except: :new
    page_vars except: [:profile, :edit_profile, :update_profile]

    before_filter :authenticate_user!, excaept: :show
    before_filter :authenticate_admin!, except: [:index, :show, :new, :create, :profile, :edit_profile, :update_profile]

    before_filter(only: [:profile, :edit_profile, :update_profile]) { set_resource_ivar current_user }

    alias_method :update_profile, :update

  end
end

module BicycleCms
  module Roler

    def signed_in_as_active_user?
      signed_in? && current_user.active?
    end

    def signed_in_as_admin?
      signed_in? && current_user.admin?
    end

    def current_user_is? user
      user == current_user
    end

    def authenticate_admin!
      authenticate_user!
      raise "You're not admin!" unless current_user.admin? # TODO
    end

    def current_user_role(options = {})
      if signed_in_as_admin?
        :admin
      elsif signed_in?
        :user
      else
        :guest
      end
    end

  end
end

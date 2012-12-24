module BicycleCms
  module Authenticater

    def signed_in_as_active_user?
      signed_in? and current_user.active?
    end

    def signed_in_as_admin?
      signed_in? and current_user.admin?
    end

    def current_user_is? user
      user == current_user
    end

    def authenticate_admin!
      authenticate_user!
      raise "You're not admin!" unless current_user.admin? # TODO
    end

  end
end

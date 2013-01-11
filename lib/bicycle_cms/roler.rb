module BicycleCms
  module Roler

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

    def current_user_type options = {}
      if signed_in_as_admin?
        :admin
      elsif signed_in?
        :user
      else
        :guest
      end
    end

    def current_user_role_for object, options = {}
      owner = options.delete(:owner) || (object.respond_to?(:owner) ? object.owner : nil)
      roles = options.delete(:roles) || [:admin, :creator, :owner, :guest]

      if roles.include?(:universal)
        ''.to_sym
      elsif roles.include?(:admin) and signed_in_as_admin?
        :admin
      elsif signed_in?
        if roles.include?(:creator) and (object.nil? or object.try :new_record?)
          :creator
        elsif roles.include?(:owner) and not owner.nil? and owner == current_user
          :owner
        elsif roles.include?(:user)
          :user
        end
      elsif roles.include?(:guest)
        :guest
      elsif roles.include?(:default)
        :default
      else
        ''.to_sym
      end
    end

  end
end

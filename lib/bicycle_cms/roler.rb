require 'bicycle_cms/authenticater'

module BicycleCms
  module Roler

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
      owner = options.delete(:owner) #XYZ || (not object.try(:author_id).nil?) ? User.find(object.author_id) : nil
      roles = options.delete(:roles) || [:admin, :creator, :owner, :guest]

      if roles.include?(:universal)
        ''.to_sym
      elsif roles.include?(:admin) and signed_in_as_admin?
        :admin
      elsif signed_in?
        if roles.include?(:creator) and object.try :new_record?
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

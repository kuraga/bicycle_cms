module BicycleCms
  class User < ActiveRecord::Base

    ## Database authenticatable
    col :email,              as: :string,  null: false
    col :encrypted_password, as: :string,  null: false

    timestamps

    col :is_admin,           as: :boolean, null: false, default: false

    has_one :profile
    delegate :name, :show_email, :gender, :avatar, to: :profile

    # TODO Роль :default не должна обладать правами (devise использует именно ее)
    attr_accessible :email, :password, :password_confirmation, :profile_attributes, as: [:creator, :owner, :admin, :default]
    add_attr_accessible :is_admin, as: :admin
    accepts_nested_attributes_for :profile, allow_destroy: true

    devise :database_authenticatable, :registerable

    include DefaultScopes
    define_default_scopes created_at: :created_at
    scope :admins,  -> { where{ is_admin == true    } }
    scope :females, -> { where{ gender == 'females' } }
    scope :males,   -> { where{ gender == 'males'   } }

    def admin?
      is_admin?
    end

  end
end

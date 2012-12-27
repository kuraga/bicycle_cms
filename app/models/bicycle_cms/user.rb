module BicycleCms
  class User < ActiveRecord::Base

    ## Database authenticatable
    col :email,              as: :string, null: false
    col :encrypted_password, as: :string, null: false

    timestamps

=begin #XYZ
        ## Recoverable
        # table.string   :reset_password_token
        # table.datetime :reset_password_sent_at

        ## Rememberable
        # table.datetime :remember_created_at

        ## Trackable
        # table.integer  :sign_in_count, :default => 0
        # table.datetime :current_sign_in_at
        # table.datetime :last_sign_in_at
        # table.string   :current_sign_in_ip
        # table.string   :last_sign_in_ip

        ## Confirmable
        # table.string   :confirmation_token
        # table.datetime :confirmed_at
        # table.datetime :confirmation_sent_at
        # table.string   :unconfirmed_email # Only if using reconfirmable

        ## Lockable
        # table.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
        # table.string   :unlock_token # Only if unlock strategy is :email or :both
        # table.datetime :locked_at

        ## Token authenticatable
        # table.string :authentication_token
=end

    col :is_admin,      as: :boolean,   null: false, default: false

    has_one :profile
    delegate :name, :show_email, :gender, :avatar, to: :profile

    # TODO Роль :default не должна обладать правами (сейчас ошибка devise)
    attr_accessible :email, :password, :password_confirmation, :profile_attributes, as: [:creator, :owner, :admin, :default]
    add_attr_accessible :is_admin, as: :admin
    accepts_nested_attributes_for :profile, allow_destroy: true

    devise :database_authenticatable, :registerable
      #XYZ :recoverable, :rememberable, :trackable, :validatable
      #XYZ :token_authenticatable, :confirmable,
      #XYZ :lockable, :timeoutable and :omniauthable

    include DefaultScopes
    #XYZ define_default_scopes is_active: :is_active, created_at: :created_at
    #XYZ scope :active, -> { where(arel_table[:is_active].eq(true)) }
    scope :admins, -> { where(arel_table[:is_admin].eq(true)) }
    scope :females, -> { where(arel_table[:gender].eq('females')) }
    scope :males, -> { where(arel_table[:gender].eq('males')) }

    def active?
      true #XYZ is_active?
    end

    def admin?
      is_admin? #XYZ is_active? and is_admin?
    end

  end
end

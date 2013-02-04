module BicycleCms
  class Profile < ActiveRecord::Base

    col :name,       as: :string,  null: false
    col :gender,     as: :integer, null: false
    col :avatar,     as: :string,  null: false, default: ''
    col :show_email, as: :boolean, null: false, default: false

    # TODO Роль :default не должна обладать правами (devise использует именно ее)
    attr_accessible :name, :show_email, :gender, :avatar, :remove_avatar, as: [:admin, :default]
    # TODO Небезопасно, так как доступео изменение чужих объектов
    mount_uploader :avatar, AvatarUploader
    enumerate(:gender) { values_id_as_name :female, :male, :undefined }
    default_values gender: 'undefined', show_email: false

    belongs_to :user

    validates :name, presence: true,
               uniqueness: true,
               length: { within: 5..50 }
    validates_inclusion_of :gender, :in => Gender # TODO Использовать validates

  end
end

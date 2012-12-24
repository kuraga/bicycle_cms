module BicycleCms
  class Attachment < ActiveRecord::Base

    col :file,         as: :string,   null: false
    col :created_at,   as: :datetime, null: false
    col :updated_at,   as: :datetime, null: false
    col :slug,         as: :string,   null: false, default: ''
    col :show_in_list, as: :boolean,  null: false, default: true

    mount_uploader :file, FileUploader
    default_values slug: '', show_in_list: true

    belongs_to :attachable, polymorphic: true

    attr_accessible :file, :slug, :show_in_list, as: [:creator, :owner, :admin]

  end
end

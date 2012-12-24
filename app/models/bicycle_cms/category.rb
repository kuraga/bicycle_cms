module BicycleCms
  class Category < ActiveRecord::Base

    col :is_published, as: :boolean,   null: false, default: true
    col :title,        as: :string,    null: false, default: ''
    col :thumbnail,    as: :string,    null: false, default: ''
    col :slug,         as: :string,    null: false, default: ''
    col :description,  as: :text,      null: false, default: ''
    col :keywords,     as: :string,    null: false, default: ''
    col :body,         as: :text,      null: false, default: ''
    col :ancestry,     as: :string,    index: true

    mount_uploader :thumbnail, ThumbnailUploader
    default_values is_published: true, title: '', slug: '', description: '', keywords: '', body: ''

    has_ancestry
    has_many :articles, foreign_key: :category_id, dependent: :destroy
    has_many :products, foreign_key: :category_id, dependent: :destroy
    has_many :attachments, as: :attachable, dependent: :destroy
    accepts_nested_attributes_for :attachments, reject_if: proc { |attrs| attrs[:file].nil? }, allow_destroy: true

    extend FriendlyId
    friendly_id :title, use: :slugged

    # TODO Решить
    root_id = 1

    attr_accessible :is_published, :ancestry, :title, :slug, :description, :keywords, :body, :thumbnail, :remove_thumbnail, :attachments_attributes, as: [:creator, :owner, :admin]

    validates :title, presence: true
    validates :slug, uniqueness: true, allow_blank: true, allow_nil: true

    include DefaultScopes
    define_default_scopes is_active: :is_published
    scope :root, -> { where(id: root_id) }
    scope :in_root, -> { where(parent_id: root_id) }

  end
end

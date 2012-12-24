module BicycleCms
  class Product < ActiveRecord::Base

    col :is_published,   as: :boolean,   null: false, default: true
    col :title,          as: :string,    null: false, default: ''
    col :thumbnail,      as: :string,    null: false, default: ''
    col :slug,           as: :string,    null: false, default: ''
    col :description,    as: :text,      null: false, default: ''
    col :keywords,       as: :string,    null: false, default: ''
    col :body,           as: :text,      null: false, default: ''
    col :is_commentable, as: :boolean,   null: false, default: true
   attr_accessible :is_published, :published_at, :category_id, :title, :slug, :description, :keywords, :body, :is_commentable, :thumbnail, :remove_thumbnail, :attachments_attributes, as: [:creator, :owner, :admin]
    mount_uploader :thumbnail, ThumbnailUploader
    default_values is_published: true, published_at: -> { DateTime.now }, category_id: 1, slug: '', description: '', keywords: '', title: '', body: '', is_commentable: true, is_page: false

    has_many :attachments, as: :attachable, dependent: :destroy
    accepts_nested_attributes_for :attachments, reject_if: proc { |attrs| attrs[:file].nil? }, allow_destroy: true
    belongs_to :category, class_name: 'Category'
    has_many :comments, as: :commentable

    validates :title, presence: true
    validates :slug, uniqueness: true, allow_blank: true, allow_nil: true

    include DefaultScopes
    define_default_scopes is_active: :is_published

    extend FriendlyId
    friendly_id :title, use: :slugged
    should_not_generate_new_friendly_id_unless_new_record_and_blank_slug!

  end
end

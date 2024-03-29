module BicycleCms
  class Event < ActiveRecord::Base

    col :is_published,   as: :boolean,   null: false, default: true
    col :published_at,   as: :timestamp, null: false
    col :title,          as: :string,    null: false, default: ''
    col :thumbnail,      as: :string,    null: false, default: ''
    col :slug,           as: :string,    null: false, default: ''
    col :description,    as: :text,      null: false, default: ''
    col :keywords,       as: :string,    null: false, default: ''
    col :body,           as: :text,      null: false, default: ''
    col :is_commentable, as: :boolean,   null: false, default: true

    mount_uploader :thumbnail, ThumbnailUploader
    default_values is_published: true, published_at: -> { Date.today }, slug: '', title: '', description: '', keywords: '', body: '', is_commentable: true

    has_many :attachments, as: :attachable, dependent: :destroy
    accepts_nested_attributes_for :attachments, reject_if: proc { |attrs| attrs[:file].nil? }, allow_destroy: true

    has_many :comments, as: :commentable

    attr_accessible :is_published, :published_at, :title, :slug, :description, :keywords, :body, :is_commentable, :thumbnail, :remove_thumbnail, :attachments_attributes, as: :admin

    # FIXME
    extend FriendlyId
    friendly_id :slug
    def slug; published_at.strftime('%Y-%m-%d'); end

    validates :published_at, uniqueness: true

    # FIXME Переместить в декоратор
    def date_title
      l(published_at, format: :date_short) + title.presense('') { ". #{title}" }
    end

  end
end

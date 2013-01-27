module BicycleCms
  class Comment < ActiveRecord::Base

    col :is_published, as: :boolean,   null: false, default: true
    col :created_at,   as: :timestamp, null: false
    col :updated_at,   as: :timestamp, null: false
    col :name,         as: :string,    null: true
    col :email,        as: :string,    null: true
    col :body,         as: :text,      null: false, default: ''

    default_values is_published: true, created_at: -> { DateTime.now }, body: ''

    belongs_to :commentable, polymorphic: true
    belongs_to :author, class_name: 'User'

    attr_accessible :created_at, :commentable_type, :commentable_id, :author_id, :name, :email, :body, :is_published, as: [:creator, :admin]
    remove_attr_accessible :created_at, :commentable_type, :commentable_id, :author_id, :name, :email, as: :owner, source_as: :creator

    validates :name, presence: true,
               length: { within: 5..50 }
    validates :email, format: { with: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
    validates :body, presence: true

    scope :anonymous, -> { where{ author_id == nil } }
    scope :publicous, -> { where{ author_id != nil } }

    def owned_by?(user)
      author.not_nil? && author.id == user.id
    end

  end
end

module BicycleCms
  class Feedback < ActiveRecord::Base

    col :created_at, as: :timestamp, null: false
    col :name,       as: :string,    null: false
    col :email,      as: :string,    null: false
    col :title,      as: :string,    null: false, default: ''
    col :body,       as: :text,      null: false, default: ''

    attr_accessible :created_at, :name, :email, :title, :body, as: [:user, :guest, :admin]
    # TODO Небезопасно, так как доступео изменение чужих объектов
    default_values created_at: -> { DateTime.now }, title: '', body: ''

    validates :name, :email, :title, :body, presence: true

    def deliver
      FeedbackMailer.feedback_message(self).deliver
    end

  end
end

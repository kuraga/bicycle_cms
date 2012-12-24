module BicycleCms
  class Mailing < ActiveRecord::Base

    col :created_at, as: :timestamp, null: false
    col :title,      as: :string,    null: false, default: ''
    col :body,       as: :text,      null: false, default: ''

    attr_accessible :created_at, :title, :body, as: [:creator, :admin]
    default_values created_at: -> { DateTime.now }, title: '', body: ''

    validates :title, presence: true
    validates :body,  presence: true

    def deliver
      User.all.each do |user|
        MailingMailer.mailing_message(self, user).deliver
      end
      true # TODO Неизвестно, все ли корректно отправлено
    end

  end
end

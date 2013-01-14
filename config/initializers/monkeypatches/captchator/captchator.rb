require 'open-uri'

module Captchator
  module Controller

    def captchator_session_id
      @captchator_session_id ||= "somestring" # FIXME shoud be: (ENV['captchator_session_id'] || session[:session_id] || "#{rand}".gsub(/[^\d]/, ''))
    end

  end
end

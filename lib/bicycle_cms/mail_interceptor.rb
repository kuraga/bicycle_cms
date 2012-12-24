module BicycleCms
  class MailInterceptor

    def self.delivering_email message
      message.subject = "[#{configatron.host}] #{message.subject}"
    end

  end
end

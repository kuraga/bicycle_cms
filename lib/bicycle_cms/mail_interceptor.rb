module BicycleCms
  class MailInterceptor

    # TODO Как-то непонятно выглядит
    def self.delivering_email(message)
      message.subject = "[#{BicycleCms.hostname}] #{message.subject}"
    end

  end
end

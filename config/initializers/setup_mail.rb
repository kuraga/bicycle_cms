require 'bicycle_cms/mail_interceptor'

ActionMailer::Base.register_interceptor BicycleCms::MailInterceptor

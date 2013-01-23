module BicycleCms
  class MailingsController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all, except: [:edit, :update]
    page_vars

    before_filter :authenticate_admin!

    def create
      create! do |success,failure|
        success.any do
          @mailing.deliver ? nil : redirect_to(new_mailing_path)
        end
      end
    end

  end
end

module BicycleCms
  class FeedbacksController < ApplicationController

    respond_to :html
    actions :all
    page_vars

    before_filter :authenticate_admin!, except: [:new, :create]

    def create
      create! do |success,failure|
        success.any do
          @feedback.deliver ? nil : redirect_to(new_feedback_path)
        end
      end
    end

  end
end

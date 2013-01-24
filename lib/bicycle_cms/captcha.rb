module BicycleCms
  module Captcha
    module Controller

      extend ActiveSupport::Concern

      included do
        helper_method :captchator_session_id
      end

      def captchator_session_id
        @captchator_session_id ||= (session[:session_id] || /\d{24}/.generate)
      end

      def verify_captchator
        open("http://captchator.com/captcha/check_answer/#{captchator_session_id}/#{params[:captchator_answer]}").read == '1'
      end
      
    end

    module View

      extend ActiveSupport::Concern

      def captchator_tags
        captchator_label + captchator_input + captchator_refresh
      end

      def captchator_label
        label_tag 'captchator_answer', captchator_image
      end

      def captchator_input
        text_field_tag(:captchator_answer)
      end

      def captchator_refresh
        link_to "Refresh captcha", {anchor: 'captchaptor_image'}, {
          id: 'captchator_refresh',
          onclick: <<-JAVASCRIPT
            var new_url = "#{captchator_image_path}?" + (new Date).getTime();
            $('#captchator_image').attr('src', new_url);
            return false;
          JAVASCRIPT
        }
      end

      def captchator_image_path
        File.join 'http://captchator.com/captcha/image', captchator_session_id
      end

      def captchator_image
        image_tag captchator_image_path, id: 'captchator_image'
      end
    end
  end
end

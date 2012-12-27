module BicycleCms
  class AvatarUploader < StandardUploader

    convert :png

    version :medium do
      resize_to_limit 250, 250
    end

    version :small do
      resize_to_limit 100, 100
    end

    version :icon do
      resize_to_fill 50, 50
    end

    def default_url
      '/assets/bicycle_cms/users/' + case model.gender
        when :female
         'no-avatar-female.png'
        when :male
         'no-avatar-male.png'
        else
         'no-avatar.png'
      end
    end

  end
end

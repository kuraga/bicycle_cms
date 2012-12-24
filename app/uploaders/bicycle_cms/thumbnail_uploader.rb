module BicycleCms
  class ThumbnailUploader < StandardUploader

    version :big do
      resize_to_limit 640, 480
    end

    version :medium do
      resize_to_limit 250, 250
    end

  end
end

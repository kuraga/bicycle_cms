# TODO Общая система доступа к файлам
# TODO convert не меняет расширения

module BicycleCms
  class StandardUploader < CarrierWave::Uploader::Base

    storage :file

    def store_dir
      "#{Rails.root}/public/uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}"
    end

    def cache_dir
      "#{Rails.root}/public/tmp/uploads"
    end

    def filename
       @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
    end

    include CarrierWave::MiniMagick

    protected

      def secure_token
        var = :"@#{mounted_as}_secure_token"
        model.instance_variable_get(var) || model.instance_variable_set(var, /\w{12}/.generate)
      end

  end
end

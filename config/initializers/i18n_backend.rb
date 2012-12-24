module BicycleCms
  module I18nBackend

    def lookup(locale, key, scope = [], options = {})
      (res = super(locale, key, scope, options)) and return res

      key_with_scope = Array.wrap(scope).present? ? "#{Array.wrap(scope).join('.')}.#{key}" : "#{key}"
      new_key_with_scope = case key_with_scope

        when /^activerecord\.models\.([\w\/]+)$/
          "#{$1.pluralize}.main.#{$1.pluralize}"
        when /^activerecord\.attributes\.([\w\/]+)\.(.+)$/
          "#{$1.pluralize}.attributes.#{$2}"

        # TODO ActiveRecord error messages

        when /^flash\.actions\.(\w+)\.(\w+)$/
          "general.messages.#{$2}.#{$3}"
        when /^flash\.([\w\/]+)\.(\w+)\.(\w+)$/
          "#{$1.pluralize}.messages.#{$2}.#{$3}"

        when /^active_enum\.([\w\/]+)\.(\w+)\.(\w+)$/
          "#{$1.pluralize}.attributes.#{$2.pluralize}.#{$3}"

        else
          key_with_scope
        end

      super(locale, new_key_with_scope, [], options)
    end

  end
end

I18n::Backend::Simple.include BicycleCms::I18nBackend

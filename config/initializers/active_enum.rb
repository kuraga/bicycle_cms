require 'active_enum'
require 'active_enum/form_helpers/formtastic2'

ActiveEnum.setup do |config|
  config.use_name_as_value = true
  config.storage = :i18n
end

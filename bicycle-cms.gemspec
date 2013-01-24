$:.push File.expand_path('../lib', __FILE__)

require 'bicycle_cms/version'

Gem::Specification.new do |specification|
  specification.name        = 'bicycle_cms'
  specification.version     = BicycleCms::VERSION
  specification.authors     = ['Kurakin Alexander']
  specification.email       = ['kuraga333@mail.ru']
  specification.homepage    = 'http://github.com/kuraga/bicycle_cms'
  specification.summary     = 'TODO: Summary of BicycleCmspecification.'
  specification.description = 'TODO: Description of BicycleCmspecification.'

  specification.files = Dir["{app,config,lib}/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  specification.test_files = []

  specification.add_dependency 'activesupport',              '~> 3.2.11'
  specification.add_dependency 'rails',                      '~> 3.2.11'

  specification.add_dependency 'sass-rails',                 '~>3.2.6'
  specification.add_dependency 'jquery-rails',               '~>2.2.0'
  specification.add_dependency 'coffee-rails',               '~>3.2.2'
  specification.add_dependency 'execjs'
  specification.add_dependency 'therubyracer',               '~>0.11.1'
  specification.add_dependency 'uglifier',                   '>=1.3.0'

  specification.add_dependency 'mini_record',                '~>0.3.1'
  specification.add_dependency 'default_value_for',          '~>2.0.1'
  specification.add_dependency 'squeel',                     '~>1.0.15'
  specification.add_dependency 'active_enum',                '~>0.9.12'
  specification.add_dependency 'randexp',                    '~>0.1.7'
  specification.add_dependency 'multiple_table_inheritance', '~>0.2.1'
  specification.add_dependency 'rails-i18n',                 '~>0.7.2'

  specification.add_dependency 'inherited_resources',        '~>1.3.1' # FIXME На github'е много новых патчей
  specification.add_dependency 'responders',                 '~>0.9.3'
  specification.add_dependency 'draper',                     '~>1.0.0'
  specification.add_dependency 'ancestry',                   '~>1.3.0'

  specification.add_dependency 'haml',                       '~>3.1.7'
  specification.add_dependency 'formtastic',                 '~>2.2.1'
  specification.add_dependency 'nested_form',                '~>0.3.1'

  specification.add_dependency 'friendly_id',                '~>4.0.9'
  specification.add_dependency 'devise',                     '~>2.1.2' # FIXME '~>2.2.2'
  specification.add_dependency 'carrierwave',                '~>0.6.0' # FIXME '~>0.8.0'
  specification.add_dependency 'mini_magick',                '~>3.4'

  specification.add_dependency 'aloha-rails-improved' # FIXME версия
end

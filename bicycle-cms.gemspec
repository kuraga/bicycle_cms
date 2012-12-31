$:.push File.expand_path('../lib', __FILE__)

require 'bicycle_cms/version'

Gem::Specification.new do |s|
  s.name        = 'bicycle_cms'
  s.version     = BicycleCms::VERSION
  s.authors     = ['Kurakin Alexander']
  s.email       = ['kuraga333@mail.ru']
  s.homepage    = 'http://github.com/kuraga/bicycle_cms'
  s.summary     = 'TODO: Summary of BicycleCms.'
  s.description = 'TODO: Description of BicycleCms.'

  s.files = Dir["{app,config,db,lib}/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = []

  s.add_dependency 'rails',                '~> 3.2.9'

  s.add_dependency 'sass-rails',           '~>3.2.3'
  s.add_dependency 'coffee-rails',         '~>3.2.1'
  s.add_dependency 'execjs'
  s.add_dependency 'therubyracer',         '~>0.10.0'
  s.add_dependency 'uglifier',             '>=1.0.3'

  s.add_dependency 'mini_record',          '~>0.3.1'
  s.add_dependency 'default_value_for',    '~>2.0.0'
  s.add_dependency 'squeel',               '~>1.0.13'
  s.add_dependency 'active_enum',          '~>0.9.11'
  s.add_dependency 'randexp',              '~>0.1.7'
  s.add_dependency 'rails-i18n',           '~>0.5.1'

  s.add_dependency 'inherited_resources',  '~>1.3.1'
  s.add_dependency 'responders',           '~>0.9.1'
#  s.add_dependency 'has_scope',           '~>0.5.1'
  s.add_dependency 'draper',               '=1.0.0.beta4'
  s.add_dependency 'ancestry',             '~>1.3.0'

  s.add_dependency 'haml',                 '~>3.1.4'
  s.add_dependency 'formtastic',           '~>2.2.0'
  s.add_dependency 'nested_form',          '~>0.3.1'
  s.add_dependency 'jquery-rails',         '~>2.0.1'

  s.add_dependency 'breadcrumbs_on_rails', '~>2.2.0'
#  s.add_dependency 'kaminari',            '~>0.13.0'
  s.add_dependency 'friendly_id',          '~>4.0.8'
#  s.add_dependency 'datagrid',            '~>0.6.4'
  s.add_dependency 'devise',               '~>2.1.2'
  s.add_dependency 'carrierwave',          '~>0.6.0'
  s.add_dependency 'mini_magick',          '~>3.4.0'
end

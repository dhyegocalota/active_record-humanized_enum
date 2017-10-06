require './lib/active_record/humanized_enum/version'

Gem::Specification.new do |spec|
  spec.name        = 'activerecord_humanized_enum'
  spec.version     = ActiveRecord::HumanizedEnum::Version::STRING
  spec.authors     = ['Dhyego Fernando']
  spec.email       = ['dhyegofernando@gmail.com']

  spec.summary     = 'Easily translate your ActiveRecord\'s enums.'
  spec.description = spec.summary
  spec.homepage    = 'http://github.com/dhyegofernando/activerecord_enum_i18n'
  spec.license     = 'MIT'

  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_dependency 'railties', '~> 4.0'
  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_dependency 'activerecord', '~> 4.0'
  spec.add_dependency 'i18n'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-utils'
  spec.add_development_dependency 'pry-meta'
end

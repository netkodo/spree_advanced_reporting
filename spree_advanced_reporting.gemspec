# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform              = Gem::Platform::RUBY
  s.name                  = 'spree_advanced_reporting'
  s.version               = '2.3.0'
  s.summary               = 'Advanced Reporting for Spree'
  s.homepage              = 'https://github.com/iloveitaly/spree_advanced_reporting'
  s.authors               = ['Steph Skardal', 'Michael Bianco', 'Nima Shariatian']
  s.email                 = ['steph@endpoint.com', 'info@cliffsidedev.com', 'nima.s@coryvines.com']
  s.required_ruby_version = '>= 1.9.3'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency 'rails', '~> 4.1.4'
  s.add_dependency 'spree_core', '~> 2.3.1'

  s.add_development_dependency 'rspec-rails', '~> 3.0.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails', '~> 4.4.1'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'capybara', '~>2.4.1'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry'

  # use https://github.com/iloveitaly/ruport/tree/wicked-pdf
  s.add_dependency 'ruport'
end

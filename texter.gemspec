# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "texter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = "texter"
	s.version     = Texter::VERSION
	s.authors     = ["Max Savchenko"]
	s.email       = ["robotector@gmail.com"]
	s.homepage    = "http://github.com/macovsky/texter"
	s.summary     = "Rails-engine для редактирования блоков текста, с поддержкой I18n"
	s.description = "* Лёгкий вывод блочных и инлайновых текстов, отформатированных с помощью Textile
* Дефолтные тексты в I18n
* После редактирования тексты хранятся в базе, перед сохранением обрабатываются Типографом Лебедева
* Удобный, встроенный в сайт интерфейс редактирования"

	s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
	# s.test_files = Dir["test/**/*"]

	s.add_dependency 'rails', '~> 3.2.9'
	s.add_dependency 'sass-rails', '~> 3.2.3'
	s.add_dependency 'draper', '~> 1.1.0'
	s.add_dependency 'RedCloth', '~> 4.2.9'
	s.add_dependency 'simple_form'
  s.add_dependency 'art_typograph'

  s.add_development_dependency 'rspec-rails', '~> 2.12'
  s.add_development_dependency 'capybara', '~> 2.0.1'
	s.add_development_dependency 'sqlite3'
	s.add_development_dependency 'database_cleaner'
end

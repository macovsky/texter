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
  s.description = "* Лёгкий вывод блочных и инлайновых текстов, отформатированных с помощью Textile, Markdown или simple_format
* Дефолтные тексты в I18n
* При редактировании тексты сохраняются в базе
* Подключаемые обработчики (препроцессоры) — можно легко подключить «Типограф Лебедева»
* Удобный, встроенный в сайт интерфейс редактирования"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]

  s.post_install_message = "Texter 1.0.0 is backwards incompatible, please take a look at the changelog."

  s.add_dependency 'rails', '>= 4.0.0'
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'simple_form'

  s.add_development_dependency 'rspec-rails', '~> 2.12'
  s.add_development_dependency 'capybara', '~> 2.0.1'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rdiscount'
  s.add_development_dependency 'RedCloth', '~> 4.2.9'
  s.add_development_dependency 'art_typograph', '~> 0.1.1'
end

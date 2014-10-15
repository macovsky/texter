# encoding: UTF-8
Texter.configure do |config|
  # по умолчанию texter не разрешает редактировать тексты
  # можно использовать следующие значения:
  #
  # * Symbol (хелпер доступный в views/controller, например :current_user — редактировать смогут только залогиненные пользователи)
  # * Proc (от двух параметров text (Texter::Text) и h — контекст views/controller, например ->(text, h) { h.current_user })
  # * любое другое значение, будет интерпретироваться как true/false выражение
  #
  # смотрите Texter::TextPresenter#can_be_edited?
  # config.can_be_edited = false

  # форматтер текста, по умолчанию :simple (хелпером simple_format)
  # доступны также :textile и :markdown (нужно установить RedCloth и rdiscount соответственно)
  # config.formatter = :simple

  # обработчики текста, обработка происходит перед сохранением текста в базу
  # по умолчанию используется Texter::CleanPreprocessor (:clean), который просто удаляет символы \r.
  #
  # texter также имеет встроенную поддержку Типографа Лебедева, подключить можно следующим образом:
  # добавить в Gemfile:
  # gem 'art_typograph', '~> 0.1.1'
  # и добавить в preprocessors :art_typograph
  #
  # config.preprocessors = [:clean]

  # по умолчанию texter ищет тексты в этом скопе:
  # config.i18n_scope = 'texter'
end

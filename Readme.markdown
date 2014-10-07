### Rails-engine для редактирования блоков текста

Начальная идея изложена в посте [«Турборедактирование кусков текста»](http://mindscan.msk.ru/programmingshit/edit-pieces-of-text.html), `Texter` развивает эту идею.

* Лёгкий вывод блочных и инлайновых текстов, отформатированных с помощью [Textile](http://redcloth.org/textile/), [Markdown](http://daringfireball.net/projects/markdown/syntax) или [simple_format](https://github.com/rails/rails/blob/21b55e4462c2a9d3a6420d2754ab63a9d6f01da8/actionpack/lib/action_view/helpers/text_helper.rb#L258) или своего форматтера
* Дефолтные тексты в `I18n`
* При редактировании тексты сохраняются в базе
* Подключаемые обработчики (препроцессоры) — можно легко подключить [Типограф Лебедева](http://www.artlebedev.ru/tools/typograf/webservice/) или другой
* Удобный, встроенный в сайт интерфейс редактирования

![](http://cl.ly/image/463H3d2J0R0T/Screen%20Shot%202013-01-02%20at%206.45.09%20PM.png)

### Подключение

```ruby
# Gemfile
gem 'texter'

# config/routes.rb
mount Texter::Engine => '/texter'
```

Миграция

```shell
rake texter:install:migrations
rake db:migrate
```

В assets pipeline нужно добавить `texter/texts.js` и `texter/_texts.scss` соответственно.

Должен быть подключен gem `jquery-rails`.

`Texter` по-умолчанию не имеет ограничений доступа.

### Как пользоваться

Пользоваться приходится следующими хелперами:

* `block(path, options = {})` — возвращает отформатированный текст для блочного элемента;
* `inline(path, options = {})` — для инлайнового (особенности вывода указаны для каждого форматтера по отдельности).

`path` — `I18n`-идентификатор текста в скопе `texter`:

```yaml
ru:
  texter:
    pages:
      index:
        header: Песня Винни-Пуха
        intro: |
          Вот горшок пустой!

          Он предмет простой!
```

в `pages/index` аналогично стандартному хелперу `translate` можно использовать полную версию или сокращённую:

```erb
<h1><%= inline "pages.index.header" %></h1>

<div><%= block ".intro" %></div>
```

получим, предсказуемо:

```html
<h1>Песня Винни-Пуха</h1>

<div><p>Вот горшок пустой!</p><p>Он предмет простой!</p></div>
```

В `options`-хеше можно передать `:locale` и `:formatter`.

### Форматтеры

`Texter` может форматировать текст следующими способами:

**:simple** — *включен по умолчанию*

Использует хелпер [simple_format](https://github.com/rails/rails/blob/21b55e4462c2a9d3a6420d2754ab63a9d6f01da8/actionpack/lib/action_view/helpers/text_helper.rb#L258).

Хелпер `inline` выдаёт текст без обработки.

**:textile**

Использует [RedCloth](https://github.com/jgarber/redcloth) (можно настроить rules и restrictions, смотрите `Texter::TextileFormatter`).

Нужно установить джем:

```ruby
# Gemfile
gem 'RedCloth', '~> 4.2.9'
```

Хелпер `inline` выдаёт весь текст, обработанный с помощью `:lite_mode` restriction.

**:markdown**

Использует [RDiscount](https://github.com/davidfstr/rdiscount) (можно настроить расширения, смотрите `Texter::MarkdownFormatter`).

Нужно установить джем:

```ruby
# Gemfile
gem 'rdiscount'
```

Хелпер `inline` выдаёт содержимое первого `<p>` или `<h\d>`.

**Установить глобальный форматтер** можно так:

```ruby
# config/initializers/texter.rb
Texter.configure do |config|
  config.formatter = :textile
end
```

Для создания других форматтеров смотрите базовый класс `Texter::Formatter`.

### Обработчики

`Texter` позволяет подключить несколько последовательных обработчиков текста (например для типографики), обработка происходит перед сохранением текста в базу.

По дефолту используется единственный `Texter::CleanPreprocessor` (`:clean`), который просто удаляет символы `\r`.

Также `Texter` имеет встроенную поддержку [Типографа Лебедева](http://www.artlebedev.ru/tools/typograf/webservice/), подключить можно следующим образом:

```ruby
# Gemfile
gem 'art_typograph', '~> 0.1.1'

# config/initializers/texter.rb
Texter.configure do |config|
  config.preprocessors = [:clean, :art_typograph]
end
```

Для создания других обработчиков смотрите базовый класс `Texter::Preprocessor`.

### Ограничение доступа

Чтобы выяснить и показать на сайте, можно ли редактировать текст, `Texter` вызывает метод `can_be_edited?` презентера `Texter::TextPresenter` (по-дефолту `true`, то есть _все могут редактировать_).

Пример настройки доступа на уровне контроллера:

```ruby
# app/controllers/texter/texts_controller.rb
require_dependency Texter::Engine.root.join("app/controllers/texter/texts_controller").to_s

class Texter::TextsController
  before_filter :authenticate_user!
end
```

### Обновления

Читайте твитторд [Прогерского говна](http://twitter.com/programmingshit).

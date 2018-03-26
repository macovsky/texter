### Rails-engine для редактирования блоков текста

* Лёгкий вывод блочных и инлайновых текстов, отформатированных с помощью [Textile](http://redcloth.org/textile/), [Markdown](http://daringfireball.net/projects/markdown/syntax), [simple_format](https://github.com/rails/rails/blob/21b55e4462c2a9d3a6420d2754ab63a9d6f01da8/actionpack/lib/action_view/helpers/text_helper.rb#L258) или своего форматтера
* Дефолтные тексты в `I18n` — сайт легко задеплоить, не заморачиваясь с миграциями/seeds
* При редактировании тексты сохраняются в базе
* Подключаемые обработчики (препроцессоры) — встроенная, опциональная поддержка [Типографа Лебедева](http://www.artlebedev.ru/tools/typograf/webservice/)
* Удобный, встроенный в сайт интерфейс редактирования

![](http://cl.ly/image/113R3A2v2n2t/Image%202014-10-14%20at%208.34.56%20PM.png)

### Установка

```ruby
gem 'texter'
```

```shell
rails g texter:install
rake texter:install:migrations
rake db:migrate
```

Генератор `texter:install`:

* создаёт `config/initializers/texter.rb` — настройки доступа к редактированию текстов (по умолчанию возможность закрыта), форматтера, обработчиков (смотрите комментарии в файле);
* создаёт `config/locales/texter.yml` — дефолтные тексты;
* подключает `Texter::Engine` в `config/routes.rb`.

В ассеты нужно добавить `texter/texts.js` и `texter/_texts.scss` соответственно.

Должны быть подключены `jquery` и `jquery_ujs` (`jquery-rails`).

### Как пользоваться

Пользоваться приходится следующими хелперами:

* `block(path, options = {})` — возвращает отформатированный текст для блочного элемента;
* `inline(path, options = {})` — для инлайнового (особенности вывода указаны для каждого форматтера по отдельности).

`path` — `I18n`-идентификатор текста в скопе `texter` (можно настроить):

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

| Форматтер | Зависимости | Хелпер `inline` выдаёт |
| :-------- | :------------- | :--------------------------  |
| **:simple:** _по умолчанию_ | нет, используется встроенный рельсовый хелпер [simple_format](https://github.com/rails/rails/blob/21b55e4462c2a9d3a6420d2754ab63a9d6f01da8/actionpack/lib/action_view/helpers/text_helper.rb#L258) | текст без обработки |
| **:textile** | gem '[RedCloth](https://github.com/jgarber/redcloth)' | весь текст, обработанный с помощью `:lite_mode` |
| **:markdown** | gem '[rdiscount](https://github.com/davidfstr/rdiscount)' | содержимое первого `<p>` или `<h\d>` |

Для создания других форматтеров смотрите базовый класс `Texter::Formatter`.

### Обработчики

`Texter` позволяет подключить несколько последовательных обработчиков текста (например для типографики), обработка происходит перед сохранением текста в базу.

По дефолту используется единственный `Texter::CleanPreprocessor` (`:clean`), который просто удаляет символы `\r`.

Также `Texter` имеет встроенную поддержку [Типографа Лебедева](http://www.artlebedev.ru/tools/typograf/webservice/), смотрите `config/initializers/texter.rb`.

Для создания других обработчиков смотрите базовый класс `Texter::Preprocessor`.

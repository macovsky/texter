**Rails-engine для редактирования блоков текста.**

Начальная идея изложена в посте [«Турборедактирование кусков текста»](http://mindscan.msk.ru/programmingshit/edit-pieces-of-text.html), `Texter` развивает эту идею:

* Лёгкий вывод блочных и инлайновых текстов, отформатированных с помощью Textile
* Дефолтные тексты в I18n
* После редактирования тексты хранятся в базе, перед сохранением обрабатываются [Типографом Лебедева](http://www.artlebedev.ru/tools/typograf/)
* Удобный, встроенный в сайт интерфейс редактирования

![](http://cl.ly/image/463H3d2J0R0T/Screen%20Shot%202013-01-02%20at%206.45.09%20PM.png)

**Подключение**

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

**Как пользоваться**

Пользоваться приходится следующими хелперами:

* `block(path)` — возвращает блочный текст (параграфы обёрнуты в `p`)
* `inline(path)` — инлайновый (`:lite_mode` в `RedCloth`)

`path` — идентификатор текста в скопе `texts`:

```yaml
ru:
  texts:
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

**Ограничение доступа**

Чтобы выяснить, можно ли редактировать текст, `Texter` вызывает хелпер `text_can_be_edited?(text)`, который, в свою очередь, вызывает хелпер `moderator_signed_in?` — можете определить тот или другой в своём приложении.

Также ограничение доступа в контроллере `Texter::TextsController` происходит по умолчанию через метод `require_moderator!` — можете переопределить это поведение в `initializer` с помощью `Texter.controller_setup`, смотрите дефолтный пример в `lib/texter.rb`.

**Многоязычность**

По умолчанию `Texter` редактирует только один текст в текущей локали, но его можно быстро подкрутить для работы с многоязычными сайтами. Русская и английская версия минимальными усилиями:

После установки миграции поправим её: 

```ruby
class CreateTexterTexts < ActiveRecord::Migration
  def change
    create_table :texter_texts do |t|
      t.string :path, :null => false, :default => ''
      t.text :body_ru
      t.text :body_en
      t.timestamps
    end
    add_index :texter_texts, :path, :unique => true
  end
end
```

Настроим модель в приложении, например в `config/initializers/texter.rb`:

```ruby
Texter.bodies = %w{body_ru body_en}

Texter::Text.class_eval do
  def body
    send("body_#{I18n.locale}")
  end

  def default_attributes
    {
      :body_ru => get_body(:locale => :ru),
      :body_en => get_body(:locale => :en)
    }
  end
end
```

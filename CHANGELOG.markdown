**1.1.0** 2013-08-11

* Пофиксил баг с необходимостью установки `RedCloth`, `rdiscount` и `art_typograph`, даже если они не используются.
* Поправил README.

**1.0.0** 2013-07-19

* Убрал ограничения доступа, теперь тексты по-умолчанию *могут редактировать все пользователи* — смотрите [README](https://github.com/macovsky/texter/blob/master/Readme.markdown).
* Убрал `draper`.
* Убрал `Texter.controller_setup` — можно открыть контроллер `Texter::TextsController` и добавить свой `before_filter`.
* Убрал `validates_presence_of *Texter.bodies` из `Texter::Text`.
* Поменял `I18n`-скоп с `texts` на `texter`.
* Добавил поддержку разных форматтеров, из коробки есть поддержка Textile, Markdown и simple_format, `:textile` и `:markdown` можно настраивать. По умолчанию включен `:simple_format`, как самый простой и не требующий дополнительных джемов.
* Добавил обработчики текста, "Типограф Лебедева" по-умолчанию выключен.
* Хелперам `inline` и `block` в options-хеше можно передать `:locale`, `:formatter` и `:formatter_options`.

**0.3.0** 2013-02-16

* Обновил `draper` до `~> 1.1.0`.

**0.2.0** 2013-02-16

* В js-скрипте `.live` заменён на `.on` ([@paraboom](https://github.com/paraboom)).

**0.1.0** 2013-01-02

* Первый релиз.

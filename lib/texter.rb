require "texter/engine"

module Texter
  # body attributes for text, array of strings
  # it can be %w{body_ru body_en} for instance, if you use multiple languages
  mattr_accessor :bodies
  self.bodies = %w{body}

  mattr_accessor :controller_setup
  self.controller_setup = proc{|controller| controller.before_filter(:require_moderator!)}
end

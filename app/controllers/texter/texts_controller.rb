require_dependency "texter/application_controller"

module Texter
  class TextsController < ApplicationController
    Texter.controller_setup.call(self)

    respond_to :js
    before_filter :load_text

    def edit
    end

    def update
      Texter::CleanBody.new(@text).clean(Texter.bodies & @text.changed)

      if @text.valid? && Texter::Typograph.new(@text).process(Texter.bodies & @text.changed)
        @text = TextDecorator.new(@text)
        render :update
      else
        render :edit
      end
    end

    private

    def load_text
      @text = Text.find_or_create_from_translations_by_path(params[:id])
      @text.attributes = params[:text]
    end
  end
end

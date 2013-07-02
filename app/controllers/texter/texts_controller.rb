require_dependency "texter/application_controller"

module Texter
  class TextsController < ApplicationController
    respond_to :js
    before_filter :load_text

    def edit
    end

    def update
      RunPreprocessorsOnText.call(@text)

      if @text.save
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

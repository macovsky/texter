require_dependency "texter/application_controller"

module Texter
  class TextsController < ApplicationController
    respond_to :js
    before_filter :load_text

    def edit
    end

    def update
      RunPreprocessorsOnText.call(@text)

      render @text.save ? :update : :edit
    end

    private

    def load_text
      @text = Text.find_or_create_from_translations_by_path(params[:id])
      @text.attributes = resource_params.except(:id)
    end

    def resource_params
      params.require(:text).permit(*Texter.bodies, :tag_type)
    end
  end
end

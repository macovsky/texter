require_dependency "texter/application_controller"

module Texter
  class TextsController < ApplicationController
    respond_to :js
    before_filter :load_text
    before_filter :ensure_text_can_be_edited

    def edit
      @text.tag_type = resource_params[:tag_type]
    end

    def update
      @text.attributes = resource_params

      RunPreprocessorsOnText.call(@text)

      render @text.save ? :update : :edit
    end

    private

    def load_text
      @text = Text.find_or_initialize_by_path(params[:id])
    end

    def ensure_text_can_be_edited
      presenter = TextPresenter.new(@text, self)
      render(nothing: true) unless presenter.can_be_edited?
    end

    def resource_params
      params.require(:text).permit(:body, :tag_type)
    end
  end
end

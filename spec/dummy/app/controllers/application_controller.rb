class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def require_moderator!
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def render_404
    render text: "404", status: 404
  end
end

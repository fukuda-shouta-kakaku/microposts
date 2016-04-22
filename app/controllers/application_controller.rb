class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    @user = User.find_by_id(params[:id])
    unless logged_in? && @user == current_user
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end

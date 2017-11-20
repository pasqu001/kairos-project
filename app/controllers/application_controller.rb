class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_admin
    @current_admin ||= Admin.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_admin

  def authorize
    redirect_to '/login' unless current_admin
  end
end

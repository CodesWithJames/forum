class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  layout 'application'
  helper_method :current_user
  before_action :loged_in, except: [:login]

  rescue_from Exception do |exception|
    Rails.logger.info(exception.message)
    Rails.logger.info(exception.backtrace.join("\n\r"))
    Rails.logger.info(exception.error)
  end

  def loged_in
    Rails.logger.info session
    ap session
    puts session
    p session
    if not session.key?(:user)
      redirect_to(login_path(login: false)) 
    end
    true
  end

  def current_user
    return if session[:user].blank?
    User.find(session[:user])
  end

end

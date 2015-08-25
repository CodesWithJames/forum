class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  layout 'application'
  helper_method :current_user
  before_action :loged_in, except: [:login]

  def loged_in
    logger.info session.inspect
    if not session.key?("user")
      redirect_to(login_url(login: false)) 
    end
    true
  end

  def current_user
    return if session["user"].blank?
    User.find(session["user"])
  end

end

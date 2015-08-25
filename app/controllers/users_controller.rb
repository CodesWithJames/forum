class UsersController < ApplicationController
  skip_before_action :loged_in,  only: [:login, :logout, :authenticate, :new, :create]

  def login
  end

  def logout
    reset_session
    redirect_to login_path
  end

  def authenticate
    begin
      @user = User.authenticate(login_params)
      session["user"] = @user.id.to_s
      redirect_to root_path
    rescue => exception
      @error = exception.error
      render action: :login
    end
  end

  def index
  end

  def create
    begin
      @user = User.build(users_params)
      session["user"] = @user.id.to_s
      redirect_to root_path
    rescue => exception
      @error = exception.error
      render :new
    end
  end

  def edit
  end
  
  def update  
  end

  private
  
  def login_params
    params.require(:user).permit(:email, :password)
  end

  def users_params
    params.require(:user).permit(:name, :email, :password)
  end
end

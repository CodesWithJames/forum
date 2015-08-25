module Authenticatable
  extend ActiveSupport::Concern

  # verify if thge user is authenticatable
  def authenticatable?
    self.class.included_modules.include?(Authenticatable)
  end

  # setup a new password and save
  def change_password params
    raise Exceptions::Simple.build(message: I18n.t("errors.messages.blank"), field: :password) if params[:password].blank?
    self.password = params[:password]
    self.save
  end

  # send email with link to change the current password
  def send_recover_password
    self.generate_password_recover
    UserMailer.recover_password(self.id).deliver_now
  end

  # start the expiration date for session, 30 days
  def start_session
    self.update_attributes(session_expires_in: 30.days.from_now)
  end

  # end the expiration date for session
  def end_session
    self.update_attributes(session_expires_in: Time.now)
  end

  # refrash the expiration date giving more 30 days
  def refresh_session
    self.update_attributes(session_expires_in: 30.days.from_now)
  end

  module ClassMethods
    # authenticate a user with email and password, raise error if email or password is invalid
    def authenticate params = {}
      validate_auth_options params
      user = find_with_email(params[:email])
      raise Exceptions::Simple.build(message: I18n.t("exceptions.auth.unauth")) unless user.authenticatable?
      user.authenticate(params[:password])
      user.start_session
      user
    end

    def sign_out params
      user = find_with_email(params[:email])
      user.validate_token(params[:token])
      user.end_session
      user
    end

    def refresh params
      user = find_with_email(params[:email])
      user.validate_token(params[:token])
      user.refresh_session
      user
    end

    # find a user with email and send an email for email recovery
    def recover_password params
      user = find_with_email(params[:email])
      user.send_recover_password
    end

    # find a user with email
    def find_with_email email
      raise_simple(:login, "exceptions.auth.invalid") unless where(email: email).exists?
      find_by(email: email)
    end

    # validate the params for authentication
    def validate_auth_options options = {}
      %i(email password).each do |attr|
        raise_simple(attr, "exceptions.auth.blank") if options[attr].blank?
      end
    end
  end
end







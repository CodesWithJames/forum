require 'bcrypt'

module Identification
  extend ActiveSupport::Concern
  include BCrypt

  # get password
  def password
    @password ||= Password.new(self.password_hash) if self.password_hash 
  end

  # set password
  def password=(new_password)
    return if new_password.blank?
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # validates the presence of password for an authenticatable
  def password_presence
    self.add_error(:password, "errors.messages.blank") unless self.password.present?
  end

  # build a secure random hex string for password recovery
  def generate_password_recover
    self.generate_token(:password_recover)
  end

  # set to blank password recovery
  def reset_password_recover
    self.update_attribute(:password_recover, "")
  end

  def authenticate password
    self.class.raise_model(:login, "exceptions.auth.invalid") if self.password != password
    true
  end
end

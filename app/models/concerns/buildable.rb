module Buildable
  extend ActiveSupport::Concern

  # build a complete update of the object
  def build_update params
    self.update_attributes(params)
    self.class.raise_model!(self.errors.first) unless self.valid?
    self.save
  end

  module ClassMethods
    # build a new user with params, raise if has errors in validation
    def build params
      object = new params
      object.status = 'active' if object.respond_to?(:status)
      raise_model!(object.errors.first) unless object.valid?
      object.save
      object
    end
  end
end

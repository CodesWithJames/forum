module Exceptional
  extend ActiveSupport::Concern

  # add an error for an attribute with the translation
  def add_error attribute, translation
    self.errors.add(attribute, I18n.t(translation))
  end

  # add an error for an attribute with the translation and raises the error
  def add_error! attribute, translation
    self.add_error(attribute, translation)
    raise Exceptions::Model.build(self)
  end

  # add an error with a message 
  def add_error_with_message attribute, message
    self.errors.add(attribute, message)
  end

  # add an error with the message and raise the error
  def add_error_with_message! attribute, message
    self.errors.add(attribute, message)
    raise Exceptions::Model.build(self)
  end

  module ClassMethods
    # raise a simple exceptions error with translation and field
    def raise_simple field, translation
      raise Exceptions::Simple.build(message: I18n.t(translation), field: field)
    end

    # add an error for an attribute and raise it
    def raise_model attribute, translation
      new.add_error!(attribute, translation)
    end

    # raise an exception for an model error
    def raise_model! error
      new.add_error_with_message!(error.first, error.last)
    end
  end
end

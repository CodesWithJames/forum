Mongoid::Errors::DocumentNotFound.class_eval do
  def error
    { 
      error: { 
        model: self.model.camelcase,
        field: "#{self.model}[id]",
        attribute: "id",
        message: "#{self.model_human.capitalize} #{I18n.t("exceptions.id_not_found")} #{self.id}",
        full_message: "#{self.model_human.capitalize} #{I18n.t("exceptions.id_not_found")} #{self.id}"
      }
    }
  end

  def status
    :not_acceptable
  end

  def klass
    klass = self.message.gsub("Couldn't find ", "")

    klass = klass.gsub(/\ AND \\\"(\w+)\\\".\\\"(\w+)\\\"\ \=\ \$2/, "")
    klass = klass.gsub(/((\ with \'id\'\=([0-9])+)|(\ with \'id\'\=)|( without an ID))/, "")
    klass = klass.gsub(/\ \[WHERE \"(\w)+\"\.\"(\w)+\"\ \= (\?|\d+)\]/, "")
    klass = klass.gsub("[", "").gsub("]", "")
    klass = klass.gsub(/\ WHERE \"([a-zA-Z]+)\"\.\"type\" IN \(\'(\W|\w)+\'\)/, "")
    klass = klass.gsub(/\ AND \"([a-zA-Z]+)\".\"([a-zA-Z_]+)\" = /, "")
    klass = klass.gsub("$2", "")
    klass = klass.gsub(/ WHERE\ \"([a-zA-Z]+)\"\.\"(.+)/, "")
    klass.demodulize
  end

  def id
    self.message.match(/([0-9])+/).to_s
  end

  # return what model is
  # @return [String]
  def model
    self.klass.constantize.name.demodulize.tableize.singularize.downcase
  end

  def model_human
    self.klass.constantize.model_name.human.demodulize.tableize.singularize.downcase
  end

end

Exception.class_eval do
  def error
    { 
      error: { 
        message: self.message,
        full_message: "Ocorreu algum erro inesperado."
      }
    }
  end

  def status
    :bad_request
  end
end

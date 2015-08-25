# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'faker'


RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/factories"
  Dir["./spec/support/**/*.rb"].sort.each { |f| require f}
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
end

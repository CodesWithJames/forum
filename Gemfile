source 'https://rubygems.org'

gem 'rails', '4.2.2'

gem 'mongoid'
gem 'bcrypt'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'awesome_print'
# gem 'mini_magick'
gem 'exceptions-resource', github: 'xdougx/exceptions-resource', require: 'exceptions'
gem 'will_paginate'
gem "will_paginate_mongoid"

# gem 'airbrake'
# gem 'newrelic_rpm'

# processors
# gem 'kaminari'
# gem 'pdfkit'
# gem 'wicked_pdf', '~> 0.9.6'
# gem 'spreadsheet'
# gem 'to_spreadsheet'

# integrations
# gem 'httparty'
# gem 'api-moip-assinaturas', :git => 'git://github.com/xdougx/api-moip-assinaturas.git', :require => 'moip'
# gem 'gattica', :git => 'https://github.com/chrisle/gattica.git'
# gem 'createsend'

# resque
# gem 'redis'
# gem 'resque', :require => 'resque/server'
# gem 'resque_mailer'
# gem 'resque-scheduler', require: 'resque-scheduler'
# gem 'resque-web', :require => 'resque_web'
# gem 'rufus-scheduler'
# gem 'delayed_job_active_record'

gem 'jquery-rails'

group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-fontawesome'
  gem 'rails-assets-underscore'
  gem 'rails-assets-jqueryui'
end


# file upload
# gem 'paperclip'
# gem 'aws-sdk', '~> 2'
# clonning
# gem 'deep_cloneable', '~> 1.5.5'

group :development, :test do
  gem 'thin'
  gem 'spring'
  gem 'web-console'
  gem 'wkhtmltopdf-binary'
  gem 'rails-erd'

  gem 'rubycritic', require: false
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  
  # rspec
  %w{rspec rspec-core rspec-rails rspec-mocks rspec-support rspec-its rspec-expectations}.each do |repo|
    gem repo, github: "rspec/#{repo}", branch: :master
  end

  # testing
  gem 'faker'
  gem 'cpf_faker'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'shoulda-matchers'

  # deploy
  gem 'capistrano', '~> 2.15.5', require: false
  gem 'rvm-capistrano', require: false
  gem "capistrano-resque", "~> 0.1.0", require: false
  gem 'net-ssh', '2.7.0'

end


group :production, :staging do
  gem 'unicorn'
  gem 'wkhtmltopdf-heroku'
end



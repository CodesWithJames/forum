# Be sure to restart your server when you modify this file.
ENV['SECRET_KEY'] = "61a4baafc085dc85646b3960c9e37035cbe877a8335b356fe12ef9f34523721f7a786a943d9d91e91a1987b32d08ced334fcd2c6896aa20911018aa996cb23ce"
Rails.application.config.session_store :cookie_store, key: '_forum_session', domain: "forum.ruby-everyday.ninja"
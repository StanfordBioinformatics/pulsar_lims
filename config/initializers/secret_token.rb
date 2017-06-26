# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Pulsar::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] #use $(rails secret) to generate a key

#nathan comments:
#	SECRET_KEY_BASE key is used to encrypt sessions in a production environment.

#	 The Rails 4 in Action book has an example of starting a production app like so:
#
#			bundle exec rake assets:precompile RAILS_ENV=production
#			bundle exec rake db:migrate RAILS_ENV=production
#	  	SECRET_KEY_BASE=`rake secret` rails s -e production
#

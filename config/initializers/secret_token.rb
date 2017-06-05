# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Pulsar::Application.config.secret_key_base = "d7759fd272c611f1c39d715a2757d8f248f9e0f36d78b65bd3c7cf9d95e68d9fbaf976677b27d1f26f009d651d10a61d43f79d300c9741e6baf72fc5771727cb"

#nathan comments:
#	Pulsar::Application.config.secret_key_base = ENV["SECRET_KEY_BASE"]
#	SECRET_KEY_BASE key is used to encrypt sessions in a production environment.

# Note that I actually set the secret key above verbosly since I am required to - I get this error otherwise when running
#	bundle exec rake db:migrate RAILS_ENV=production:
#	"""Devise.secret_key was not set. Please add the following to your Devise initializer:

#	 config.secret_key = 'd7759fd272c611f1c39d715a2757d8f248f9e0f36d78b65bd3c7cf9d95e68d9fbaf976677b27d1f26f009d651d10a61d43f79d300c9741e6baf72fc5771727cb'"""
#
#	 The Rails 4 in Action book has an example of starting a production app like so:
#
#			bundle exec rake assets:precompile RAILS_ENV=production
#			bundle exec rake db:migrate RAILS_ENV=production
#	  	SECRET_KEY_BASE=`rake secret` rails s -e production

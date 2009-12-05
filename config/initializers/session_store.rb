# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_neoviz_session',
  :secret      => '4aa1b1e1620d6737d055237de8b3414b63b16f06dae3c2943c2895872f20efe2e887029a4ef12bfc92846f83435dd4aad0f43a8c9d0bd45a986c956e9a41dce8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

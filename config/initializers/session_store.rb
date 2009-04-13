# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => 'freeforms_session',
  :secret      => '828cba1314d54ea07f6bf017c5cf192d2a179d4db8e0d592cfc7058409607aa6c78b4356397bde7a7348b8d5454800ecd2a615cdb17f10d16496e00db13a8801'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Regenerate secret token and store it in file that is gitignored.
#Kinfonet4::Application.config.secret_key_base = 'cd95150aa29e377f61d94d42f01aa3c882bd9ceadfc77eb2f5abb83c75afd4bb040b3697ee26da805e3803b8d5aae042b389fa6d6459fd09832d6c0bde9ea3c4'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Kinfonet4::Application.config.secret_key_base = secure_token
require 'sinatra'
require 'sqlite3'
require './models/user'
require 'securerandom'
require 'rack/protection'

use Rack::Protection::AuthenticityToken

# Database connection setup
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/users.db'
)

# Define User model
class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  has_secure_password
end

# Home route (for authenticated users)
get '/' do
  user_id = request.cookies['user_id']
  if user_id && (@user = User.find_by(id: user_id))
    erb :home
  else
    redirect '/login'
  end
end

# Login page (GET request)
get '/login' do
  erb :login
end

# Login form (POST request)
post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    # Set a cookie for the user ID
    response.set_cookie('user_id', {
      value: user.id,
      path: '/',
      httponly: true,       
      secure: false          
    })
    redirect '/'
  else
    @error = "Invalid username or password."
    erb :login
  end
end

# Route to handle preference selection
post '/prefer' do
  "heeo"
  # puts "Preference received: #{params[:preference]}"
  # preference = params[:preference]
  # response.set_cookie('preference', {
  #   value: preference,
  #   path: '/',
  #   httponly: true
  # })
  # redirect '/'
end


# Logout (clear cookies)
get '/logout' do
  response.delete_cookie('user_id')  # Deletes the cookie
  redirect '/login'
end

# Register a new user (GET route)
get '/register' do
  erb :register
end

# Register a new user (POST route)
post '/register' do
  user = User.new(username: params[:username], password: params[:password])
  if user.save
    # Set a cookie for the user ID after successful registration
    response.set_cookie('user_id', {
      value: user.id,
      path: '/',
      httponly: true,
      secure: false
    })
    redirect '/'
  else
    @error = "Registration failed."
    erb :register
  end
end

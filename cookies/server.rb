# app.rb
require 'sinatra'

# Route to set a cookie
get '/' do
  # Check if the cookie is set
  if request.cookies["user_name"]
    "Hello, #{request.cookies['user_name']}!"
  else
    "Hello, Guest!"
  end
end

# Route to set a new cookie
get '/set_cookie' do
  # Set a cookie with the name 'user_name' and value 'RubyUser'
  response.set_cookie("user_name", "RubyUser")
  "Cookie has been set! Go back to the home page."
end

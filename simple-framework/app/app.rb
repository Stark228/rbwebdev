# app.rb
require 'rack'
require_relative '../lib/server.ruredirect.ru'
require_relative 'app/controllers/home_controller'
require_relative 'app/routes'

class App
  def call(env)
    Server.call(env)
  end
end

require './app'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/users.db'
)

run Sinatra::Application

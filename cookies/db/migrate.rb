# db/migrate.rb
require 'sqlite3'
require 'active_record'

# Set up ActiveRecord connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/users.db'
)

# Create users table if it doesn't exist
unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |t|
    t.string :username
    t.string :password_digest
    t.timestamps
  end
end

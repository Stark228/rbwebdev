require 'singleton'

####################################################
# class Logger
#   include Singleton

#   attr_accessor :message

#   def initialize
#     @message = "default"
#   end

#   def log(message)
#     case message
#     when 1
#       "success"
#     when 2
#       "good"
#     else
#       "error"
#     end
#   end
# end

# logger1 = Logger.instance
# logger1.message = 1
# puts logger1.log(logger1.message)  

# logger2 = Logger.instance
# puts logger1.equal?(logger2)  
######################################################


class DatabaseConnection
  include Singleton

  def initialize
    @connection = nil
  end

  # Simulate establishing a database connection
  def connect
    if @connection.nil?
      @connection = "Database Connection Established"
      puts @connection
    else
      puts "Already connected to the database."
    end
  end

  # Simulate closing the database connection
  def disconnect
    if @connection
      puts "Database Connection Closed"
      @connection = nil
    else
      puts "No active connection to close."
    end
  end
end

# Usage Example:

# Access the singleton instance and connect to the database
db_connection1 = DatabaseConnection.instance
db_connection1.connect  # Output: Database Connection Established

# Try connecting again (should output that it's already connected)
db_connection2 = DatabaseConnection.instance
db_connection2.connect  # Output: Already connected to the database.

# Disconnect from the database
db_connection1.disconnect  # Output: Database Connection Closed

# Try disconnecting again (should output that no active connection exists)
db_connection2.disconnect  # Output: No active connection to close.

# Verify that db_connection1 and db_connection2 are the same instance
puts db_connection1.equal?(db_connection2)  # Output: true, both are the same instance



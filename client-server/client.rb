require 'socket'

class SimpleHTTPClient
  def initialize(host, port)
    @host = host
    @port = port
  end

  def send_request
    socket = TCPSocket.new(@host, @port)

    request = "GET / HTTP/1.1\r\nHost: #{@host}\r\nConnection: close\r\n\r\n"
    socket.puts request
    puts "Sent Request:\n#{request}"

    puts "Response from Server:"
    while line = socket.gets
      puts line
    end
    
    socket.close
  end
end

client = SimpleHTTPClient.new('localhost', 4000)
client.send_request

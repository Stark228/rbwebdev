require 'socket'

class SimpleHTTPServer
  def initialize(host, port)
    @server = TCPServer.new(host, port)
    puts "HTTP Server is running on http://#{host}:#{port}"
  end

  def start
    loop do
      client = @server.accept
      handle_request(client)
    end
  end

  private

  def handle_request(client)
    request_line = client.gets
    puts "Received Request: #{request_line}"

    if request_line.start_with?("GET / ")
      response_body = html_response("Welcome to the HTTP Server", "This is a simple web page served by Ruby!")
    else
      response_body = html_response("404 Not Found", "The page you are looking for does not exist.", 404)
    end

    client.puts response_body

    client.close
  end

  def html_response(title, message, status_code = 200)
    status_text = status_code == 200 ? "OK" : "Not Found"
    headers = [
      "HTTP/1.1 #{status_code} #{status_text}",
      "Content-Type: text/html",
      "Connection: close"
    ]

    body = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>#{title}</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 2em;
          }
          h1 {
            color: #333;
          }
          p {
            color: #666;
          }
        </style>
      </head>
      <body>
        <h1>#{title}</h1>
        <p>#{message}</p>
        <footer><small>Powered by SimpleHTTPServer</small></footer>
      </body>
      </html>
    HTML

    headers << "Content-Length: #{body.bytesize}"

    headers.join("\r\n") + "\r\n\r\n" + body
  end
end

server = SimpleHTTPServer.new('localhost', 4000)
server.start

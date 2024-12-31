require 'webrick'

public_folder = './public'
views_folder = './view'

server = WEBrick::HTTPServer.new(
  Port: 4000,
  BindAddress: 'localhost',
  DocumentRoot: public_folder
)

server.mount_proc '/' do |req, res|

  file_path = File.join(views_folder, 'index.html')
  if File.exist?(file_path)
    res.status = 200
    res['Content-Type'] = 'text/html'
    res.body = File.read(file_path)
  else
    res.status = 404
    res.body = '404 Not Found'
  end
end

trap('INT') { server.shutdown }

puts "Server is running at http://localhost:4000"
server.start

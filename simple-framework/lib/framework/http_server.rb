# lib/framework/http_server.rb
require 'rack'

module Framework
  class HTTPServer
    def self.call(env)
      # Create a Rack::Request object to parse the incoming HTTP request
      request = Rack::Request.new(env)

      # Create a Rack::Response object to build the HTTP response
      response = Rack::Response.new

      # Log the incoming request details (optional, for debugging)
      log_request(request)

      # Delegate routing to the Router to find the appropriate controller and action
      controller, action = Router.match(request.path_info)

      if controller && action
        # If route is found, create an instance of the controller and pass the request to it
        controller_instance = controller.new(request)  # Passing the request to the controller

        # The controller's render method is responsible for rendering the view and generating the response body
        body = controller_instance.render(action)

        # Set the response body content
        response.write(body)

        # Optionally, set the status (200 OK by default) and content-type (text/html by default)
        response.status = 200
        response['Content-Type'] = 'text/html'
      else
        # If route is not found, set the response status to 404 Not Found and return a message
        response.status = 404
        response['Content-Type'] = 'text/plain'  # Plain text response for error
        response.write("404 - Page Not Found")
      end

      # Return the finished response (status, headers, and body)
      response.finish
    end

    private

    def self.log_request(request)
      # Example logging of the incoming request for debugging
      puts "Request: #{request.request_method} #{request.path_info}"
    end
  end
end

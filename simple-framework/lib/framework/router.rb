# lib/framework/router.rb
module Framework
  class Router
    @routes = {}

    def self.draw(&block)
      instance_eval(&block)
    end

    def self.get(path, to:)
      controller, action = to.split('#')
      @routes[path] = { controller: controller, action: action }
    end

    def self.match(path)
      route = @routes[path]
      if route
        controller_class = Object.const_get("#{route[:controller].capitalize}Controller")
        action = route[:action]
        [controller_class, action]
      else
        [nil, nil]
      end
    end
  end
end

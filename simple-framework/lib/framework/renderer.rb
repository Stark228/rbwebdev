# lib/framework/renderer.rb
require 'erb'

module Framework
  class Renderer
    def self.render(view_path, locals = {})
      file_path = File.join("app/views", "#{view_path}.html.erb")
      template = File.read(file_path)
      ERB.new(template).result_with_hash(locals)
    end
  end
end

# app/controllers/application_controller.rb
class ApplicationController
  # Common methods for all controllers can be added here.
  def render_view(view_name)
    File.read(File.join(__dir__, "../views/#{view_name}.html.erb"))
  end
end

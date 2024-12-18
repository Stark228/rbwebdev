# app/controllers/about_controller.rb
class AboutController < ApplicationController
  def index
    render_view('about/info') # Assuming you have a view file at app/views/about/index.html.erb
  end
end

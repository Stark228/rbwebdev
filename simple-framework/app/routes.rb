# app/routes.rb
puts "Framework module: #{defined?(Framework)}"
puts "Router class: #{defined?(Framework::Router)}"

Framework::Router.draw do
  get "/", to: "home#index"
  get "/contact", to: "home#contact"
  get "/about", to: "about#info"
end

require 'faker'

name = Faker::Name.name

address = Faker::Address.full_address

puts "Name: #{name}"
puts "Address: #{address}"
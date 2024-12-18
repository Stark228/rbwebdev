class Person
    attr_accessor :name, :age
  
    def initialize(name, age)
      @name = name
      @age = age
    end
  
    def display
      puts "Hi, I am #{@name}, I am #{@age} years old"
    end
  end
  
  puts "Enter Your Name: "
  name = gets.chomp 
  
  puts "Enter Your Age: "
  age = gets.chomp.to_i 
 
  obj = Person.new(name, age)
  
  obj.display
  
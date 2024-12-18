
class Example
  def do_something
    banana = "variable"

    puts banana
    puts self.banana
  end

  def banana
    "method"
  end
end
Example.new.do_something

#############################################################

# class Example
#   def initialize(name)
#     @name = name
#   end

#   def show_name
#     self.display_name
#   end

#   def display_name
#     @name
#   end
# end

# obj = Example.new("Ruby")
# puts obj.show_name 

############################################################

# class Example
#   def self.class_method
#     puts "Inside class method, self is #{self}"
#   end
# end

# Example.class_method  


class Rectangle
    attr_accessor :length, :breadth
    def initialize(length, breadth)
        @length = length
        @breadth = breadth
    end
    def calculate
       area = @length * @breadth
       return area
    end
end

obj = Rectangle.new(5, 5)
puts (obj.calculate)
obj.length = 5
obj.breadth = 10
puts (obj.calculate)
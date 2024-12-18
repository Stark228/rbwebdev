class Shape
  def initialize(shape)
    @shape = shape
  end

  def shape_type
    "#{@shape}"
  end
end

class Circle < Shape
  def initialize(radius)
    super("Circle")  
    @radius = radius
  end

  def Carea
    area = 3.14 * @radius * @radius
    return area
  end
end

class Square < Shape
  def initialize(length, breadth)
    super("Square")  
    @length = length
    @breadth = breadth
  end

  def Sarea
    area = @length * @breadth
    return area
  end
end

shape1 = Circle.new(5)
puts "Area of #{shape1.shape_type}: #{shape1.Carea}"

shape2 = Square.new(4, 4)
puts "Area of #{shape2.shape_type}: #{shape2.Sarea}"

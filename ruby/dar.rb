module Vehicle
  class Car
    def initialize(make, model)
      @make = make
      @model = model
    end

    def details
      "This is a #{@make} #{@model}."
    end
  end
end

class User
  def initialize(name, make, model)
    @name = name
    @car = Vehicle::Car.new(make, model)
  end

  def show_details
    "#{@name} owns a #{@car.details}"
  end
end

user1 = User.new("Alice", "Tesla", "Model 3")
puts user1.show_details  

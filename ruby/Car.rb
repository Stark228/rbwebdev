class Car
  @@count = 0
  WHEELS = 4
  $manufacturer = 'Toyota'
  def initialize(model)
    @model = model
    @@count += 1
  end
  def display
    value2 = 2
    mess = "Car model is #{@model}. It has #{WHEELS} wheels. It is manufactured by #{$manufacturer}. #{@@count} . #{value2}"
    return mess
  end
end

car1 = Car.new('shshs')
car2 = Car.new('djjdsh')
p (car1.display)
p (car2.display)
p ($manufacturer)

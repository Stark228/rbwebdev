class Vihicle
  def start_engine()
    p "Engine Started"
  end
end
class Car < Vihicle
  def hook()
    p "Beep beep!"
  end
end

# obj = Vihicle.new
# obj.start_engine

sobj = Car.new
sobj.start_engine
sobj.hook
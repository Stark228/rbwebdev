class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  public
  def introduce
    puts "Hi, my name is #{@name}."
  end

  private
  def show_age
    puts "I am #{@age} years old."
  end

  protected
  def compare_age_with_friend
    puts "Let's compare ages with a friend! (Accessible only within the class or subclasses)"
  end
end

class Friend < Person
  def initialize(name, age)
    super
  end

  def compare_with_other(friend)
    puts "#{@name} is comparing ages with #{friend.instance_variable_get(:@name)}."
    compare_age_with_friend
  end
end

person = Person.new("Alice", 25)
person.introduce

friend1 = Friend.new("Bob", 30)
friend2 = Friend.new("Charlie", 35)

friend1.compare_with_other(friend2) 

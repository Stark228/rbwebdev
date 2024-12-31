module Greet
  def reet(name)
    "Hello, #{name}"
  end
  def reet1(name)
    "sorry, #{name}"
  end
end
class User
  include Greet
  attr_accessor :name
  def initialize(name)
    @name = name
  end
  def show
    return reet(@name), reet1(@name)
  end
end

user1 = User.new('sonam')
p (user1.show)
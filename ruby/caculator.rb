
module MathOperations
    def add(num1, num2)
        num1 + num2
    end
    def subtract(num1, num2)
        num1 - num2
    end
    def multiply(num1, num2)
        num1 * num2
    end
    def divide(num1, num2)
        num1 / num2
    end
end
module Answer
    def answer(ans)
        "Answer: #{ans}"
    end   
end
class Calculator
    include MathOperations
    include Answer
    attr_accessor :operator, :num1, :num2

    def initialize(operator, num1, num2)
        @operator, @num1, @num2 = operator, num1, num2 
    end
    def calculate
        case @operator
        when "1"
            answer(add(@num1, @num2))
        when "2"
            answer(subtract(@num1, @num2))
        when "3"
            answer(multiply(@num1, @num2))
        when "4"
            answer(divide(@num1, @num2))
        else
            'error'
        end
    end
end

p "Enter Operater \n 1->+ \n 2->- \n 3->* \n 4->/"
operator = gets.chomp.to_s
p "Enter Num1"
num1 = gets.chomp.to_f
p "Enter num2"
num2 = gets.chomp.to_f
cal1 = Calculator.new(operator, num1, num2)

puts cal1.calculate


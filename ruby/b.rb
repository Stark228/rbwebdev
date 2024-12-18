class BankAccount
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def withdraw(amount)
    if amount > @balance
      puts "Insufficient funds! Withdrawal denied."
      return false
    end
    @balance -= amount
    puts "Withdrawal successful! New balance: $#{@balance}"
    true
  end

  def withdraw!(amount)
    if amount > @balance
      raise "Insufficient funds! Cannot withdraw $#{amount} from an account with a balance of $#{@balance}."
    end
    @balance -= amount
    puts "Withdrawal successful! New balance: $#{@balance}"
    true
  end
end

account = BankAccount.new(100)
account.withdraw!(110)
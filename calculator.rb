class Calculator
    attr_reader :result
    def initialize(left, right)
      @left = left
      @right = right
      @result = 0
    end
  
    def sum
      @result = @left + @right
    end
  
    def subtraction
      @result = @left - @right
    end
  
    def multiply
      @result = @left * @right
    end
  
    def divide
      @result = @left / @right
    end
  
    def exponentiation
      @result = @left ** @right
    end
  end

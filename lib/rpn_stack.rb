# handles basic stack and arithmetic operations
class RPNStack
  attr_reader :stack

  def initialize
    @stack = []
  end

  def perform_op(input)
    return :count_error unless @stack.count > 1
    second = pop
    first = pop
    case input.to_sym
    when :+
      add(first, second)
    when :-
      subtract(first, second)
    when :*
      multiply(first, second)
    when :/
      divide(first, second)
    end
  end

  def add(f, s)
    push(f + s)
  end

  def subtract(f, s)
    push(f - s)
  end

  def multiply(f, s)
    push(f * s)
  end

  def divide(f, s)
    if s.zero?
      push(f)
      push(s)
      return :divide_error
    else
      push(f / s)
    end
  end

  def push(num)
    @stack << num.to_f
    last
  end

  def pop
    @stack.pop
  end

  def last
    @stack.last
  end
end

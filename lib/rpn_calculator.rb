# RPN class
class RPNCalculator
  OPERATORS = [:+, :-, :*, :/].freeze

  attr_reader :stack

  def initialize
    @stack = []
  end

  private

  def start!
    input = nil
    until input == 'q'
      print '> '
      input = STDIN.gets.chomp
      valid_input?(input) ? handle_input(input) : invalid_input_prompt
    end
    display(@stack.last)
  end

  def valid_input?(input)
    input == 'q' || operator?(input) || number?(input)
  end

  def handle_input(input)
    return if input == 'q'
    operator?(input) ? perform_op(input) : push(input)
  end

  def invalid_input_prompt
    puts 'Invalid input, Try again. =('
  end

  def perform_op(input)
    return puts 'Not enough numbers! =(' unless @stack.count > 1
    second = pop
    first = pop
    case input.to_sym
    when :+
      final = add(first, second)
    when :-
      final = subtract(first, second)
    when :*
      final = multiply(first, second)
    when :/
      final = divide(first, second)
    end
    push(final)
  end

  def add(f, s)
    f + s
  end

  def subtract(f, s)
    f - s
  end

  def multiply(f, s)
    f * s
  end

  def divide(f, s)
    if s.zero?
      puts "Can't divide by zero. =("
      push(f)
      s
    else
      f / s
    end
  end

  def push(num)
    @stack << num.to_f
    display(num)
  end

  def pop
    @stack.pop
  end

  def display(num)
    int = num.to_i
    flo = num.to_f
    puts int == flo ? int : flo
  end

  def number?(input)
    Float(input).is_a?(Float)
  rescue
    false
  end

  def operator?(input)
    OPERATORS.include?(input.to_sym)
  end

  def current_input_prompt
    print @stack.to_s + "\n"
  end
end

### Starts on script ###

if $PROGRAM_NAME == __FILE__
  puts 'Starting...'
  puts 'Type q to exit at anytime'
  rpn = RPNCalculator.new
  rpn.send(:start!)
end

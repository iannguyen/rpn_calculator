require_relative './rpn_display'
require_relative './rpn_stack'

class RPNCalculator
  OPERATORS = [:+, :-, :*, :/].freeze

  attr_reader :display, :stack

  def initialize
    @display = RPNDisplay.new
    @stack = RPNStack.new
  end

  def start!
    input = nil
    until input == 'q'
      prompt
      input = STDIN.gets.chomp
      status = evaluate(input)
      log(status)
    end
  end

  def evaluate(input)
    return stack.last if input == 'q'
    if number?(input)
      push(input)
    elsif operator?(input)
      perform_op(input)
    else
      invalid_input
    end
  end

  def number?(input)
    Float(input).is_a?(Float)
  rescue
    false
  end

  def operator?(input)
    OPERATORS.include?(input.to_sym)
  end

  def push(input)
    @stack.push(input)
  end

  def perform_op(input)
    @stack.perform_op(input)
  end

  def prompt
    display.prompt
  end

  def log(status)
    display.log(status)
  end

  def invalid_input
    display.invalid_input
  end
end

### Starts on script ###

if $PROGRAM_NAME == __FILE__
  puts 'Starting...'
  puts 'Type q to exit at anytime'
  rpn = RPNCalculator.new
  rpn.send(:start!)
end

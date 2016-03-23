require_relative '../lib/rpn_calculator'

class RPNCalculator
  def test_input(input)
    valid_input?(input) ? handle_input(input) : invalid_input_prompt
  end
end

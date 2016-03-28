# handles all stdout messages for the calculator
class RPNDisplay
  def prompt
    print '> '
  end

  def log(status)
    return unless status
    case status
    when :count_error
      count_error
    when :divide_error
      divide_error
    else
      show(status)
    end
  end

  def show(num)
    int = num.to_i
    flo = num.to_f
    puts int == flo ? int : flo
  end

  def invalid_input
    puts 'Invalid input, Try again. =('
  end

  def count_error
    puts 'Not enough numbers.'
  end

  def divide_error
    puts "Can't divide by zero."
  end
end

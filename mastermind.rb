# method for spliting numbers
module NumberSpliter
  @possible_digit = [1, 2, 3, 4, 5, 6]

  private

  def split_number(number)
    number.split('')
    number.each(&:to_i)
  end

  def number_cleaning(number)
    if number.instance_of?(Array)
      if number.length > 4
        number.pop(number.length - 4)
      elsif number.length < 4
        (number.length - 4).times(number.push(@possible_digit.sample))
      end
      number.each{ |digit| digit = 6 unless digit.between?(1, 6)}
    else
      puts 'You need to pass an array'
    end
  end
end

# Code maker
class CodeMaker
  include NumberSpliter

  @notice = "Give a four-digit number with each digit smaller than 6 \n
            NOTE:if given a longer number, I use only the first four digits,digit greater than 6 becomes 6"
  def initialize(type)
    case type
    when type == true
      puts @@NOTICE
      @number = gets.chomp
      split_number(@number)
      number_cleaning(@number)
    when type == false
      make_number
    else
      puts 'type needs to be player or computer'
    end
  end

  private

  def make_number
    @number = []
    4.times do
      @number.push(@possible_digit.sample)
    end
  end
end

# Code breaker
class CodeBreaker
  include NumberSpliter
  @turns = 12
  def initialize(type)
    @type = type
  end

  def play_game
  end
end

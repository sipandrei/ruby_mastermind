# Code maker
class CodeMaker
  def initialize(type)
    case type
    when type == true
      puts 'Give a four-digit number with each digit smaller than 6'
      @number = gets.chomp.split('').map { |digit| digit.to_i }
      number_cleaning
    when type == false
      make_number
    end
  end

  private

  def make_number
    @number = []
    4.times do
      @number.push(@possible_digit.sample)
    end
  end

  def number_cleaning
    if @number.instance_of?(Array)
      if @number.length > 4
        @number.pop(@number.length - 4)
      elsif @number.length < 4
        (4 - @number.length).times { @number.push((Array 1..6).sample) }
      end
      @number.each_with_index { |digit, index| @number[index] = 6 unless digit.between?(1, 6) }
      p @number
    else
      puts 'You need to pass an array'
    end
  end
end

# Code breaker
class CodeBreaker
  @turns = 12
  def initialize(type)
    @type = type
  end

  def play_game
  end
end

CodeMaker.new(true)

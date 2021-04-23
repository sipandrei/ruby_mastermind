# class for number cleaning
class NumberFunctions
  def initialize(number)
    @number = number
  end

  protected

  def read_num
    puts 'Give a four-digit number with each digit smaller than 6'
    @number = gets.chomp.split('').map(&:to_i)
  end

  def number_cleaning
    if @number.instance_of?(Array)
      if @number.length > 4
        @number.pop(@number.length - 4)
      elsif @number.length < 4
        (4 - @number.length).times { @number.push((Array 1..6).sample) }
      end
      @number.each_with_index { |digit, index| @number[index] = 6 unless digit.between?(1, 6) }
    else
      puts 'You need to pass an array'
    end
  end

  def make_number
    @number = []
    4.times do
      @number.push((Array 1..6).sample)
    end
  end
end

# Code maker
class CodeMaker < NumberFunctions
  attr_reader :number

  def initialize(type)
    if type == true
      read_num
      super(@number)
      number_cleaning
    else
      make_number
      puts '--- The computer picked his number ---'
      puts ''
    end
  end
end

# Code breaker
class CodeBreaker < NumberFunctions
  attr_reader :turns, :game_ended

  def initialize(type, turns)
    super(nil)
    @type = type
    @turns = turns
    @game_ended = false
    @player = type == true ? 'You' : 'The computer'
  end

  def play_turn(code_maker_object)
    if @type == true
      player_input(code_maker_object)
    else
      computer_input(code_maker_object)
    end
    puts ''
  end

  private

  def player_input(code_maker_object)
    read_num
    number_cleaning

    good_place(code_maker_object.number)
    good_numbers(code_maker_object.number)

    number_feedback

    @turns -= 1
    turns_done(code_maker_object.number)
  end

  def computer_input(code_maker_object)
    make_number
    puts "The computer picked #{@number.join} as his choice"
    good_place(code_maker_object.number)
    good_numbers(code_maker_object.number)

    number_feedback

    @turns -= 1
    turns_done(code_maker_object.number)
    sleep(1)
  end

  def turns_done(code_maker_number)
    puts ''
    if @turns.zero?
      @game_ended = true
      puts "--- No more turns left, #{@player.downcase} lost, the correct number was #{code_maker_number.join}. ---"
    elsif !@game_ended
      puts "#{@turns} more turns to go!"
    end
  end

  def number_feedback
    if @good_place == 4
      puts "\n"
      puts "--- #{@player.capitalize} won the game! ---"
      @game_ended = true
    else
      puts "#{@good_numbers} correct numbers and #{@good_place} numbers in the right spot"
    end
  end

  def good_place(code_maker_number)
    @good_place = 0
    @number.each_with_index do |digit, index|
      @good_place += 1 if digit == code_maker_number[index]
    end
  end

  def good_numbers(code_maker_number)
    @good_numbers = 0
    @number.uniq.each do |digit|
      @good_numbers += 1 if code_maker_number.include?(digit)
    end
  end
end

puts 'Do you want to play as the Code Maker or as the Code Breaker?'
choice = ''
until choice.upcase == 'M' || choice.upcase == 'B'
  puts 'Answer with M or B'
  choice = gets.chomp
  choice = choice[0]
end

type = choice.upcase == 'M'

puts ''

cm = CodeMaker.new(type)
cb = CodeBreaker.new(!type, 12)

cb.play_turn(cm) while cb.game_ended == false

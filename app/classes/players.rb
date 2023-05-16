require 'io/console'
require "#{File.dirname(File.realpath(__FILE__))}/difficulty.rb"

class Player
  include TicTacToe::Commons
  attr_accessor :kind, :symbol, :player_number
  def initialize(kind, symbol, player_number)
    @kind = kind
    @symbol = symbol
    @player_number = player_number
    @adversary_symbol = @symbol == TTT_SYMBOLS[0] ? TTT_SYMBOLS[1] : TTT_SYMBOLS[0]
  end

  # as ruby doesn't have abstract classes,
  # this is a way to do so...
  MethodMissingError = "SYSTEM ERROR: method missing"
  def get_spot(board); raise MethodMissingError; end

  def valid_input?(board, input)
    # validating accecpted input
    if input >= 0 && input <= 8
      # if spot is not taken
      if board[input].is_a? Numeric
        return true
      end
    end
    false
  end
end

class HumanPlayer < Player
  def initialize(kind, symbol, player_number)
    super(kind, symbol, player_number)
  end

  def get_spot(board)
    # for humans, it's just a matter of asking for input
    spot = nil
    until spot
      # the sleeps are just for a better user experience
      sleep(0.5)
      puts "\n#{@name}"
      puts "You are #{@symbol}"
      sleep(0.25)
      #  for humans, it's more natural values from 1 to 9
      #  instead of 0 to 8
      puts "Select a spot: [1-9]"
      spot = (gets.chomp.to_i) - 1
      return spot if valid_input?(board, spot)
      puts "Invalid input! Try again."
      spot = nil
    end
  end
end

class ComputerPlayer < Player
  attr_accessor :expertise
  def initialize(kind, symbol, player_number)
    super(kind, symbol, player_number)
    set_difficulty
  end
  def get_spot(board)
    # for computer, it's a little bit more complex
    # it's necessary to evaluate the board and
    # choose the best spot
    get_best_spot(board)
  end

  def get_best_spot(board)
    # the expertise class is responsible for
    # evaluating the board and returning the best spot
    @expertise.get_best_move(board, @player_number)

  end

  def set_difficulty
    difficulty = nil

    until difficulty
      puts "Set difficulty level for Player #{@player_number} (#{@kind}):"
      puts "[1] Easy"
      puts "[2] Medium"
      puts "[3] Hard"
      selection = gets.chomp.to_i
      difficulties = %w(Easy Medium Hard).freeze

      if selection.between?(1,difficulties.length)
        difficulty = difficulties[selection - 1] + "Difficulty"
        puts "Difficulty level for Player #{@player_number} is set to #{difficulties[selection - 1]}!"
        puts "\nGood luck!\n\n" if difficulties[selection - 1] == "Hard"
        puts "Press any key to continue..."
        STDIN.getch
        puts "\n\n"
      else
        puts "Invalid difficulty level! Try again."
      end
    end

    difficulty_level = Object.const_get difficulty

    @expertise = difficulty_level.new(@player_number)
  end
end
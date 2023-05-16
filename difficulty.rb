require './modules.rb'

class Difficulty
  include TicTacToeCommons

  attr_accessor :level
  @level = "Medium"
  MethodMissingError = "SYSTEM ERROR: method missing"

  def initialize(player)
    @player_number = player
    @my_symbol = TTT_SYMBOLS[@player_number -1]
    @adversary_symbol = @my_symbol == TTT_SYMBOLS[0] ? TTT_SYMBOLS[1] : TTT_SYMBOLS[0]
  end

  def get_best_move(board, depth = 0); raise MethodMissingError; end

  def get_available_spaces(board)
    available_spaces = []
    board.each do |s|
      if s.is_a? Numeric
        available_spaces << s
      end
    end
    available_spaces
  end

end

class MediumDifficulty < Difficulty
  @level = "Medium"

  def get_best_move(board, depth = 0, best_score = {})
    available_spaces = get_available_spaces(board)
    best_move = nil

    available_spaces.each do |as|
      spot = as.to_i - 1
      board[spot] = @my_symbol
      if game_is_over?(board)
        # if with that move, the computer wins,
        # or forces a Tie, return that move
        puts "I either win or force a tie with #{spot + 1}! So I'll take it!"
        return spot
      else
        board[spot] = @adversary_symbol
        if game_is_over?(board)
          # if with that move, the adversary wins, return that move
          # Computer doesn't want the adversary to win
          puts "Adversary wins with #{spot + 1}! So I'll take it!"
          return spot
        else
          # if no one wins, lets try next move...
          board[spot] = as
        end
      end
    end

    # if no move wins, return a random move
    n = rand(0..available_spaces.count)
    puts "I decided to take #{available_spaces[n]} randomly!"
    return available_spaces[n].to_i - 1
  end
end

class EasyDifficulty < MediumDifficulty
  @level = "Easy"
  # TODO: implement for Easy Difficulty
end

class HardDifficulty < MediumDifficulty
  @level = "Hard"
  # TODO: implement for Hard Difficulty
end
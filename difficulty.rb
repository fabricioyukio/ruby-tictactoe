require './modules.rb'

# Implements the difficulty levels
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

  # the method that will be called by the game
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

# Represents the difficulty level Medium
# The machine tries to at each move, survey for EITHER
# a winning move, or a move that forces a tie
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
        # I either win or force a tie with this move, so I'll take it!
        return spot
      else
        board[spot] = @adversary_symbol
        if game_is_over?(board)
          # if with that move, the adversary wins, return that move
          # Computer doesn't want the adversary to win
          # Adversary wins with this move, so I'll take it!
          return spot
        else
          # if no one wins, lets try next move...
          board[spot] = as
        end
      end
    end

    # if no move wins, return a random move
    n = rand(0..available_spaces.count)
    # I decided to take #{available_spaces[n]} randomly!
    return available_spaces[n].to_i - 1
  end
end

# Represents the difficulty level Easy
# The machine tries to at each move, just to
# survey for the first available spot
class EasyDifficulty < MediumDifficulty
  @level = "Easy"
  # TODO: implement for Easy Difficulty
  def get_best_move(board, depth = 0, best_score = {})
    available_spaces = get_available_spaces(board)
    return available_spaces[0].to_i - 1
  end
end

# Represents the difficulty level Hard
# The machine tries to get the best move

class HardDifficulty < MediumDifficulty
  @level = "Hard"
  # TODO: implement for Hard Difficulty
end
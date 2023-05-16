# require './modules.rb'

# Implements the difficulty levels
class Difficulty
  include TicTacToe::Commons

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

  # It just takes the first available spot,
  # from left to right, top to bottom
  def get_best_move(board, depth = 0, best_score = {})
    available_spaces = get_available_spaces(board)
    return available_spaces[0].to_i - 1
  end
end

# Represents the difficulty level Hard
# The machine tries to get the best move
class HardDifficulty < MediumDifficulty
  @level = "Hard"

  # It takes the best move, based on the
  # Minimax algorithm
  def get_best_move(board, depth = 0, best_score = {})
    available_spaces = get_available_spaces(board)
    best_move = nil

    evaluations = []
    available_spaces.each do |as|
      spot = as.to_i - 1
      evaluations << {
        spot: spot,
        eval: evaluate(board, spot, @player_number, @player_number, depth=0)
      }
    end

    sorted_evals = evaluations.sort_by! { |e| -e[:eval] }
    best_eval = sorted_evals[0]
    return best_eval[:spot]

  end

  # Evaluates the move, based on the Minimax algorithm
  # Recursively evaluates the next possible moves,
  # and the next, and the next...
  # as more possible moves result in a win, the greater is the score
  # if a move results in a tie, the score is 1
  # if a move results in loss, the score is negative
  def evaluate(board, next_move, next_player, favoured_player, depth=0)
    current_player = next_player == 1 ? 2 : 1
    next_player = current_player == 1 ? 2 : 1
    evaluation_direction = current_player == favoured_player ? 1 : -1
    ev_board = board.clone
    ev_board[next_move] = TTT_SYMBOLS[current_player - 1]

    # if the move will result in a win,
    # and the one who will win is the
    # favoured player return 10
    # else it returns -10
    if wins?(ev_board)
      # if current player wins,
      # return +10 if favored player is current player
      # else return -10
      return 10 * evaluation_direction
    elsif game_is_over?(ev_board)
      # if by current move, no one wins,
      # but the game is over,
      # return 1 if favored player is current player
      # anyways, a Tie is better than a loss,
      # but not that good...
      # else return -1
      return 1 * evaluation_direction
    else
      # if the current move results in no one winning,
      # and the game is not over, check the possible
      # next moves
      available_spaces = get_available_spaces(ev_board)
      score = -depth # as more distant the move is, the less it is desirable
      available_spaces.each do |as|
        spot = as.to_i - 1
        score += evaluate(ev_board, spot, next_player, favoured_player, depth + 1)
      end
      return score
    end
  end
end
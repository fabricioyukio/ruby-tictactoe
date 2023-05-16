# common methods for both players,
# difficulty and game
# also shared constants
module TicTacToe
  module Commons
    # symbols for the game
    # the first symbol is for player 1
    # but it could be any symbol
    # that you like
    TTT_SYMBOLS = ["⛌", "❍"]

    def game_is_over?(board)
      wins?(board) or tie?(board)
    end

    # scans the board for a winning combination
    # it scans for columns, rows and diagonals
    # if there is a winning combination
    # (all spots in board are the same symbol),
    # it returns true (else false)
    def wins?(board)
      # columns
      [board[0], board[1], board[2]].uniq.length == 1 ||
      [board[3], board[4], board[5]].uniq.length == 1 ||
      [board[6], board[7], board[8]].uniq.length == 1 ||
      # rows
      [board[0], board[3], board[6]].uniq.length == 1 ||
      [board[1], board[4], board[7]].uniq.length == 1 ||
      [board[2], board[5], board[8]].uniq.length == 1 ||
      # diagonals
      [board[0], board[4], board[8]].uniq.length == 1 ||
      [board[2], board[4], board[6]].uniq.length == 1
    end

    # Scans the board for a tie:
    # if all spots in board are taken
    # and there is no winning combination,
    # then it's a tie (returns true)
    def tie?(board)
      board.all? { |s| TTT_SYMBOLS.include? s }
    end

  end
end
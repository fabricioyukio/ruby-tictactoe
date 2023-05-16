module TicTacToeCommons
  # common methods for both players, difficulty and game
  TTT_SYMBOLS = ["⛌", "❍"]

  def game_is_over?(board)
    wins?(board) or tie?(board)
  end

  def wins?(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie?(board)
    board.all? { |s| TTT_SYMBOLS.include? s }
  end

end
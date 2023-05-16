require 'io/console'

class Player
  attr_accessor :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  # as ruby doesn't have abstract classes,
  # this is a way to do so...
  MethodMissingError = "SYSTEM ERROR: method missing"
  def get_input; raise MethodMissingError; end

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
  def initialize(name, symbol)
    super(name, symbol)
  end

  def get_input(board)
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
  def initialize(name, symbol)
    super(name, symbol)
  end
end

class Game
  def initialize
    @board = arr = Array((1...10))
    @turn = 0
    @players = []
  end

  def start_game
    STDOUT.clear_screen
    puts "Welcome to Tic Tac Toe Game!!"
    puts "Starting a new game...\n\n"
    player_select
    puts "All set! Let's start the game!\n\n"
    sleep(1) # wait just a delay for the user to read the messages

    until game_is_over(@board)
      @turn += 1
      draw_board
      current_player = @turn % 2 == 0 ? @players[1] : @players[0]
      input = current_player.get_input(@board)
      @board[input] = current_player.symbol
    end
    draw_board
    puts "Game over"
    outcome
  end

  # draws updated board
  def draw_board
    STDOUT.clear_screen
    puts "\nTIC-TAC-TOE"
    puts "* Turn: #{@turn} *\n"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "===+===+==="
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "===+===+==="
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} \n"

    unless game_is_over(@board)
      current_player = @turn % 2 == 0 ? @players[1] : @players[0]
      puts "Now playing #{current_player.symbol} (#{current_player.name})..."
    end
  end

  def player_select
    simbols = ["⛌", "❍"]
    puts "**| Player Selection }**\n\n"
    for i in 0..1
      until @players[i]
        puts "Select Player #{(i+1)}: [1] Human [2] Computer"
        choice = gets.chomp.to_i
        if choice == 1
          @players[i] = HumanPlayer.new("Player #{(i+1)} - Human", simbols[i])
          puts "Selected Human for Player #{(i+1)}\n\n"
        elsif choice == 2
          @players[i] = ComputerPlayer.new("Player #{(i+1)} - Computer", simbols[i])
          puts "Selected Computer for Player #{(i+1)}\n\n"
        else
          puts "Invalid player choice!\n\n"
        end
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @player_X
      else
        spot = get_best_move(@board, @player_X)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @player_X
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @player_X
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @player_O
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b)
    tie(b) ||
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  def outcome
    if tie(@board)
      puts "It's a tie!"
    else
      winner = @turn % 2 == 0 ? @players[1] : @players[0]
      puts "#{winner.name} using #{winner.symbol} wins!"
      puts "Flawless victory!" if @turn <= 6 # flawless victory if game ends in 6 turns or less
    end
  end

end

game = Game.new
game.start_game

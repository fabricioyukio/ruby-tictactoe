require 'io/console'
require "#{File.dirname(File.realpath(__FILE__))}/players.rb"


class Game

  include TicTacToe::Commons

  def initialize
    @board = Array((1...10))
    @turn = 0
    @in_review = false
    @players = []
    @moves = []
  end

  # initialize the game
  def start_game
    STDOUT.clear_screen
    puts "Welcome to Tic Tac Toe Game!!"
    puts "Starting a new game...\n\n"
    player_select
    puts "All set! Let's start the game!\n\n"
    puts "Press any key to continue..."
    STDIN.getch # wait just a delay for the user to read the messages

    game_on

    draw_board(@board)

    reveal_outcome
    draw_game_over

    puts "\n\nPress [1] for review, any other key to exit."
    choice = gets.chomp.to_i
    if choice == 1
      review
    end
  end

  # loops the game
  def game_on
    until game_is_over?(@board)
      @turn += 1
      draw_board(@board)
      current_player = @turn % 2 == 0 ? @players[1] : @players[0]
      spot = current_player.get_spot(@board)
      log_move(current_player, spot)
      @board[spot] = current_player.symbol
    end
  end

  # draws updated board
  def draw_board(board = @board)
    STDOUT.clear_screen unless in_review?
    puts "\nTIC-TAC-TOE" unless in_review?
    puts "* Turn: #{@turn} *\n"
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "===+===+==="
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "===+===+==="
    puts " #{board[6]} | #{board[7]} | #{board[8]} "

    unless game_is_over?(board) || in_review?
      current_player = @turn % 2 == 0 ? @players[1] : @players[0]
      puts "\nNow playing Player #{current_player.player_number}\nwith #{current_player.symbol} (#{current_player.kind})..."
    end
  end

  def draw_game_over
    puts "\n\n"
    puts "+===========+"
    puts "| Game over |"
    puts "+===========+"
    puts "\n\n"
  end

  def player_select
    puts "**| Player Selection }**\n"
    for i in 0..1
      until @players[i]
        puts "Select Player #{(i+1)}:\n[1] for Human\n[2] for Computer"
        choice = gets.chomp.to_i
        if choice == 1
          @players[i] = HumanPlayer.new("Human", TTT_SYMBOLS[i], i+1)
        elsif choice == 2
          @players[i] = ComputerPlayer.new("Machine", TTT_SYMBOLS[i], i+1)
        else
          puts "Invalid player choice!\n\n"
        end
      end
    end
    puts "Player 1: using #{@players[0].symbol} (#{@players[0].kind})"
    puts "Player 2: using #{@players[1].symbol} (#{@players[1].kind})"
  end

  def log_move(player, spot)
    @moves << { symbol: player.symbol, spot: spot, player: player.player_number }
  end

  def reveal_outcome
    if tie?(@board)
      puts "It's a tie!"
    else
      winner = @turn % 2 == 0 ? @players[1] : @players[0]
      puts "Player #{winner.player_number} (#{winner.kind}) using #{winner.symbol} wins!"
      puts "Flawless victory!" if @turn <= 6 # flawless victory if game ends in 6 turns or less
    end
  end

  def in_review?
    @in_review
  end

  def review
    @in_review = true
    puts "**| Beginning Review |**"
    review_board = Array((1...10))
    @turn = 0
    draw_board(review_board)
    @moves.each do |move|
      sleep(1) # wait a second before showing the next move
      @turn += 1
      puts "\n\n"
      review_board[move[:spot]] = move[:symbol]
      draw_board(review_board)
      puts "Player #{move[:player]} turn:"
      puts "#{move[:symbol]} at #{move[:spot]+1}."
    end
  end
end
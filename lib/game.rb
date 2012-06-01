# starts the game
# coordinates  input from players
# validates input from players 
# prints messages
require 'board'

class Game
  attr_reader :size
  def initialize(board_side_length, player1, player2)
    @player1 = player1
    @player2 = player2
    @size = board_side_length ** 2
  end

  def switch(player)
    if player == @player1
      @player2
    else
      @player1
    end
  end

  def print_welcome_message
    puts "Welcome to TikTak Toe Ruby!"
  end

  def valid_input?(str)
    !!(str =~ /^[0-9]+$/)
  end
  
  def start
    board = Board.new(@board_size)
    print_welcome_message
    player = @player1
    [:x, :o].cycle.take(@board_size).each do |mark|
      board.print
      move = player.get_move
      until valid_input?(move) and board.legal_move?(move)
        move = player.get_move
      end
      board.place(move, mark)
      if board.winner?
        board.print
        puts "winner!"
        break
      end
    end
    puts "Tie game!" unless board.winner?
  end
end


# starts the game
# coordinates  input from players
# validates input from players 
# prints messages
require 'board'

Welcome_message = "Welcome to TikTak Toe Ruby!"

class Game
  attr_reader :size, :board
  def initialize(board_side_length, player1, player2)
    @player1 = player1
    @player2 = player2
    @length = board_side_length
    @size = board_side_length ** 2
    @board = Board.new(@length)
  end

  def switch(player)
    if player == @player1
      @player2
    else
      @player1
    end
  end

  def valid_input?(str)
    !!(str =~ /^[0-9]+$/)
  end

  def get_move(player)
    begin 
      input = player.get_move 
      move = input.to_i
    end until valid_input?(input) and @board.legal_move?(move)
    move
  end
  
  def start
    puts Welcome_message
    [[:x, @player1], [:o, @player2]].cycle(@size).each do |mark, player|
      board.print
      board.place(mark, get_move(player))
      if board.winner?
        puts "Player #{mark} wins!"
        break
      end
    end
    board.print
    puts "Tie game!" unless board.winner?
  end
end


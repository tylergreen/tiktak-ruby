# starts the game
# coordinates  input from players
# validates input from players 
# prints messages
require 'board'

Welcome_message = "Welcome to TikTak Toe Ruby!"

class Game
  attr_reader :size, :board
  def initialize(board_side_length, player1, player2, block_rule_option=false)
    @player1 = player1
    @player2 = player2
    @length = board_side_length
    @size = board_side_length ** 2
    @board = Board.new(@length)
  end

  def valid_input?(input)
    input.class == Fixnum or (input =~ /^[0-9]+$/)
  end

  def get_move(player)
    begin 
      @board.print
      input = player.get_move(@board) 
      move = input.to_i
    end until valid_input?(input) and @board.legal_move?(move)
    move
  end 

  def turns
    [[:x, @player1], [:o, @player2]].cycle.take(@size)
  end

  def play
    turns.find( lambda{[ "Tie Game!"]} ) do |mark, player|
      board.place(mark, get_move(player)).winner?
    end.first
  end

end

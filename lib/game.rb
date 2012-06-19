require 'board'
require 'block_rule_board'

class Game
  attr_reader :size, :board
  def initialize(board_side_length, player1, player2, block_rule_option=false)
    @player1 = player1
    @player2 = player2
    @board = if block_rule_option
               BlockRuleBoard.new(board_side_length)
             else
               Board.new(board_side_length)
             end
  end
    
  def valid_input?(input)
    input.class == Fixnum or (input =~ /^[0-9]+$/)
  end

  def get_move(player)
    begin 
      input = player.get_move(@board) 
    end until valid_input?(input) and @board.available?(input.to_i)
    input.to_i
  end 

  def play
    turns = [[:x, @player1], [:o, @player2]].cycle.take(@board.size)
    turns.find( lambda{[ "Tie Game!"]} ) do |mark, player|
      @board.place(mark, get_move(player)).winner?
    end.first
  end

end

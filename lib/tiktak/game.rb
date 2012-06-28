require 'tiktak/board'
require 'tiktak/block_rule_board'
require 'tiktak/frontends'

class Game
  attr_reader :size, :board, :result
  def initialize(board_side_length, player1, player2, block_rule_option=false, output=NoDisplay.new)
    @player1 = player1
    @player2 = player2
    @output = output
    @result = nil
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

  def game_loop
    turns = [[:x, @player1], [:o, @player2]].cycle.take(@board.size)
    @result = turns.find( lambda{[ "Tie Game!"]} ) do |mark, player|
      move = get_move(player)
      new_board = @board.place(mark, move)
      @output.show(new_board)
      new_board.winner?
    end.first
  end

  def play
    @output.show(@board)
    result = game_loop
    @output.result(result)
    result
  end

end

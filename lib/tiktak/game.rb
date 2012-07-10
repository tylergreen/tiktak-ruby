require 'tiktak/board'
require 'tiktak/block_rule_board'

class Game
  attr_reader :board, :result, :running, :current_player
  def initialize(board_side_length, block_rule_option=false)
    @result = nil
    @running = false
    @board = if block_rule_option
               BlockRuleBoard.new(board_side_length)
             else
               Board.new(board_side_length)
             end
  end
    
  def start
    @running = true
    @current_player = :x
    self
  end

  def next_player
    @current_player = case @current_player
                      when :x then :o
                      when :o then :x
                      end
  end

  def valid_input?(position)
    position.class == Fixnum
  end

  def turns(player1, player2)
    [[:x, player1], [:o, player2]].cycle.take(@board.size)
  end

  def make_move(marker, position)
    if marker == @current_player and valid_input?(position) and @board.available?(position)
      @board.place(marker, position)
      if @board.winner?
        @running = false
        @result = @board.winner?
      else
        next_player
        :ok  
      end
    else
      "bad move: #{position}"
    end
  end

end

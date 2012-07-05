require 'tiktak/board'
require 'tiktak/block_rule_board'
require 'tiktak/frontends'

class Game
  attr_reader :size, :board, :result, :running, :current_player
  def initialize(board_side_length, player1, player2, block_rule_option=false, output=NoDisplay.new)
    @player1 = player1.new(:x)
    @player2 = player2.new(:o)
    @output = output
    @result = nil
    @running = false
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

  def start
    @running = true
    next_turn
  end

  def next_player
    @current_player = case @current_player
                      when @player1 then @player2
                      when @player2 then @player1
                      when nil then @player1
                      end
  end


  def next_turn
    player = next_player 
    if player.ai?
      make_move(player.marker, player.get_move(@board))
    else
      # notify client that the server is waiting for a move
    end
    self
  end

  def make_move(marker, position)
    if valid_input?(position) and @board.available?(position)
      @board.place(marker, position)
      @output.show(board)
      if @board.winner?
        @running = false
        @result = @board.winner?
      else
        next_turn
        :ok  
      end
    else
      "bad move: #{position}"
    end
  end

end

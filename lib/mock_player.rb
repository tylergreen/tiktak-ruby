require 'player'

class MockPlayer < Player
  def initialize(move_stream)
     @move_stream = move_stream
  end

  def get_move(board)
    @move_stream.shift
  end
  
end

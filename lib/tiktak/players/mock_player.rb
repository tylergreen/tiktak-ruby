require 'tiktak/players/player'

class MockPlayer < Player
  def initialize(marker, move_stream)
    @marker = marker
    @move_stream = move_stream
  end

  def get_move(board)
    @move_stream.shift
  end
  
end

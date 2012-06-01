class MockPlayer
  def initialize(move_stream)
     @move_stream = move_stream
  end
  
  def get_move
    @move_stream.shift
  end
  
end

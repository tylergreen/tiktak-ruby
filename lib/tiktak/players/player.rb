class Player 

  attr_reader :marker
  def initialize(marker=nil)
    @marker = marker
  end

  def ai?
    true
  end

  def get_move(board)
  end

end

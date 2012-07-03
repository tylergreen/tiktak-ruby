require 'backports'
require 'tiktak/players/player'

class RandomAI < Player
  
  def get_move(board)
    board.available_moves.sample
  end


end

require 'players/minimax/minimax'
require 'players/player'

class MinimaxAI < Player

  def get_move(board)
    Minimax.minimax(@marker, board)
  end
  
end

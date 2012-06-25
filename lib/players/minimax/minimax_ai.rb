require 'players/minimax/minimax'
require 'players/player'

class MinimaxAI < Player

  def get_move(board)
    if board.size < 4
      Minimax.minimax(@marker, board)
    else
      Minimax.minimax(@marker, board, true, 10)
    end
  end
  
end

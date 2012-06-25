require 'tiktak/players/minimax/minimax'
require 'tiktak/players/player'

class MinimaxAI < Player

  SearchDepth = 3
  def get_move(board)
    if board.size < 4
      Minimax.minimax(@marker, board)
    else
      Minimax.minimax(@marker, board, true, SearchDepth)
    end
  end
  
end

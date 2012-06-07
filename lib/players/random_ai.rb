require 'players/player'

class RandomAI < Player
  
  def get_move(board)
    board.available_positions.sample
  end


end

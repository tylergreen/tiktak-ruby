require 'backports'

class MediumAI < Player

  def get_move(board)
    moves = board.available_moves
    moves.find(lambda{ moves.sample }) do |move|
      board.copy.place(@marker, move).terminal?
    end
  end
end

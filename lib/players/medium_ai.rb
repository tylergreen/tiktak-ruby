class MediumAI < Player

  def get_move(board)
    moves = board.available_moves
    moves.find(lambda{ moves.sample }) do |move|
      board.clone_and_place(@marker, move).terminal?
    end
  end
end

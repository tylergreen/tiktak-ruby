require 'tiktak/players/player'

class Human < Player

  def get_move(board)
    STDIN.readline
  end

end

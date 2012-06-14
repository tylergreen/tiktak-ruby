require 'players/player'

class Human < Player

  def echo(msg)
    puts msg
  end

  def get_move(board)
    board.print
    STDIN.read(2)
  end
  
end

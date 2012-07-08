require 'tiktak/players/player'

class Human < Player

  def valid_input?(input)
    input =~ /^[0-9]+$/
  end

  def get_move(board)
    begin 
      input = STDIN.readline
      valid = valid_input?(input) and board.available?(input.to_i)
      puts "invalid input: #{ input }" unless valid
    end until valid
    input.to_i
  end

  def ai?
    false
  end

end

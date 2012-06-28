require 'json'
require 'socket'

class CL_Display
  def show(board)
    puts board.to_s
  end

  def result(result)
    puts result
  end
  
end

class TCP_Display

  def show(board)
    conn = TCPSocket.new 'localhost', 9010
    conn.puts({'command' => "show_new_board",
                'board' => board.format}.to_json )
  end

  def result(result)
    conn = TCPSocket.new 'localhost', 9010
    conn.puts({'command' => "game_over",
                'result' => result}.to_json )
  end
    
end

class NoDisplay
  def show(board)
  end

  def result(result)
  end
end

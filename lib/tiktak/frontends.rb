require 'json'
require 'socket'

class CL_Display
  def show(board)
    board.print
  end
  
end

class TCP_Display

  def show(board)
    conn = TCPSocket.new 'localhost', 9010
    conn.puts ({'command' => "show_new_board",
                  'board' => board.format}.to_json )
    #confirm = @conn.gets
  end
    
end

class NoDisplay
  def show(board)
  end
end

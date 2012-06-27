class CL_Display
  def show(board)
    board.print
  end
  
end

class TCP_Display
  def initialize
      @conn = TCPSocket.new 'localhost', 9004
  end

  def show(board)
    @conn.puts "update_board #{board.to_a}\n"
  end
    
end

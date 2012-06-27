class TCP_Player < Player

  def initalize(marker)
    @conn = TCPSocket.new 'localhost', 9004
  end

  # this only handles the happy path
  def get_move
    conn.puts "get_move\n"
    conn.gets
  end

  def rpc(socket,request)
    socket.puts request
    socket.gets 
  end
end

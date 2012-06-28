require 'socket'

class TCP_Player < Player

  # this only handles the happy path
  def get_move(board)
    conn = TCPSocket.new 'localhost', 9010
    conn.puts({'command' => 'get_move'}.to_json)
    response = conn.gets.strip # expecting json back?
    response
  end

  def rpc(socket,request)
    socket.puts request
    socket.gets 
  end
end

module Minimax

  def self.value(board,player)
    case board.winner?
    when player then 1
    when nil then 0
    else -1
    end
  end

 def self.switch(player)
   case player
   when :x then :o
   when :o then :x
   end
 end

 def self.minimax(player, board)
   board.available_moves.max_by do |move|
     value_for(player, board.clone_and_place(player, move)) 
   end
 end

 # assumes just made move , returns value for a board
 def self.value_for(player, board)
   if board.terminal?  # I know what the value of a terminal board is for myself
     value(board, player)
   else # otherwise I assume opponent picks his best move
     score = board.available_moves.map do |move|
       value_for(switch(player), board.clone_and_place(switch(player), move))
     end.max 
     - score
   end
 end
 
 def self.minimax_old(player, board)
   board.available_moves.max_by { |move| value_for(player, board.clone_and_place(player, move))}
 end

end



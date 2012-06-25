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

 def self.minimax(player, board, limit=false, depth=3)
   board.available_moves.max_by do |move|
     move_value(player, move, board, limit, depth)
   end
 end

 def self.move_value(player, move, board, limit=false, depth=3)
   board = board.clone_and_place(player, move)
   if board.terminal? 
     value(board, player)
   elsif limit and depth == 0
     0 # unknown
   else 
     ok_move, losing_move = false
     board.available_moves.find do |move|
       case move_value(switch(player), move, board, limit, depth - 1)
       when 1 
         losing_move = true
         true
       when 0
         ok_move = true
         false
       else
         false
       end
     end
     if losing_move 
       -1
     elsif ok_move
       0
     else
       1  
     end
   end
 end
 
end



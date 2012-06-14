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
     move_value(player, move, board)
   end
 end

 def self.move_value(player, move, board)
   board = board.clone_and_place(player, move)
   if board.terminal? 
     value(board, player)
   else 
     ok_move = false
     losing_move = false
     board.available_moves.find do |move|
       case move_value(switch(player), move, board)
         when 0
         ok_move = move
         false
         when 1
         losing_move = move
         true
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



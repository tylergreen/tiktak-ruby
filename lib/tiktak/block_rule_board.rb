require 'tiktak/board'

class BlockRuleBoard < Board

  def winner?
    winner = (rows + columns + diagonals + blocks).find() do |sequence|
      sequence.first != :empty and sequence.all?{ |x| x == sequence.first }
    end
    winner ? winner.first : nil
  end

  def blocks
    (0...@length - 1).flat_map do |row|
      (0...@length - 1).map do |col|
        [rows[row][col],
         rows[row + 1][col], 
         rows[row ][col + 1],
         rows[row + 1][col + 1] ]
      end
    end
  end
end

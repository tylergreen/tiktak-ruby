class ProtoBoard

  def initalize(size)
    @size = size
  end

  def available?(position)
    @board[position] == :empty 
  end

  def legal_move?(position)
    ((@size ** 2) - 1) >= position and position >= 0 and available?(position)
  end
  
  def place(marker, position)
    @board[position] = marker
    self
  end
  
end

class ArrayBoard < ProtoBoard
  def initialize(length)
    @length = length
    @size = length ** 2
    @board = [:empty].cycle(@size).to_a
  end

  def to_a
    @board
  end
  
  def rows
    @board.each_slice(3).to_a
  end

  def columns
    @board.each_with_index.
      group_by {|x,i| i % @length }.
      values.
      flatten(1).
      map{ |x,i| x }.
      each_slice(3).
      to_a
  end
  
  def diagonals
    d1 = Range.new(0, @size).step(@length + 1).map{ |pos| @board[pos] }
    d2 = Range.new(@length - 1, @size - @length).step(@length - 1).map{ |pos| @board[pos] }
    [d1,d2]
  end
   
end

class HashBoard < ProtoBoard
  def initialize
    @board = Hash.new(:empty)
  end

  def to_a
    @board
  end

end

class Board < ArrayBoard
  
end

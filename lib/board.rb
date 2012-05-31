class ArrayBoard
  def initialize
    @board = [:empty].cycle(9).to_a
  end

  def to_a
    @board
  end
  
  def available?(i)
    @board[i] == :empty 
  end

  def legal_move?(i)
    8 >= i and i >= 0 and available?(i)
  end
  
    
end

class HashBoard
  def initialize
    @board = Hash.new(:empty)
  end

  def to_a
    @board
  end

  def available?(i)
    @board[i] == :empty 
  end

  def legal_move?(i)
    8 >= i and i >= 0 and available(i)
  end
  
end

class Board < ArrayBoard
  
end

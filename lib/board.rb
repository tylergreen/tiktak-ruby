class Board
  attr_reader :size, :length
  def initialize(length, layout=nil)
    @length = length
    @size = length ** 2
    @board = [:empty].cycle(@size).to_a
    if layout
      layout.each_with_index do |mark, i|
        place(mark,i)
      end
    end
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

  def available?(position)
    @board[position] == :empty 
  end

  def available_positions
    (0..@size).select{ |position| available? position }
  end

  def legal_move?(position)
    [@size > position,
     position >= 0,
     available?(position)
    ].all?
  end
  
  def place(marker, position)
    @board[position] = marker
    self
  end
  
  def diagonals
    d1 = Range.new(0, @size).step(@length + 1).map{ |pos| @board[pos] }
    d2 = Range.new(@length - 1, @size - @length).step(@length - 1).map{ |pos| @board[pos] }
    [d1,d2]
  end

  def winner?
    winner = (rows + columns + diagonals).find do |sequence|
      sequence.first != :empty and sequence.group_by{ |x| x }.length == 1
    end
    winner.first if winner
  end

  def format
    rows.map do |r|
       r.map { |position| position == :empty ? '_' : position }
    end
  end

  def print
    format.each{ |row| STDERR.puts row.inspect }
  end

end

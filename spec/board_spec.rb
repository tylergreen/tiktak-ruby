require 'minitest/spec'
require 'minitest/autorun'
require 'board'

describe Board do
  describe "board functionality" do
    it "is empty when created" do
      assert_equal(Board.new(3).to_a, [:empty].cycle(9).to_a())
    end
    
    it "knows if a spot is available" do
      assert Board.new(3).available?(rand(9))
    end

    it "knows if a move is legal" do
      (0..8).each do |pos|
        assert(Board.new(3).legal_move?(pos), "failed for #{pos}")        
      end
      assert not(Board.new(3).place(:x,0).legal_move?(0))
    end

    it "can have pieces placed on it" do 
      assert not(Board.new(3).place(:x,0).legal_move?(0))
      assert([:x, :o, :empty], Board.new(3).place(:x,0).place(:o,3).rows.first )
    end

    it "provides access to rows" do
      assert_equal([[:empty, :empty, :empty]].cycle(3).to_a, Board.new(3).rows)
      assert([:x, :o, :empty], Board.new(3).place(:x,3).place(:o,4).rows[2] )
    end
    
    it "provides access to columns" do
      assert_equal([[:empty, :empty, :empty]].cycle(3).to_a, Board.new(3).columns)
      assert_equal([:x, :o, :x], Board.new(3).place(:x, 0).place(:o, 3).place(:x, 6).columns.first)
      assert_equal([:x, :o, :x], Board.new(3).place(:x, 1).place(:o, 4).place(:x, 7).columns[1])
    end
  end

  it "provides access to its diagonals" do
    assert_equal([[:x, :x, :empty], [:empty, :x, :o]],
                 Board.new(3).place(:x, 0).place(:x, 4).place(:o, 6).diagonals)
  end

  
    
end

    
    
  
  

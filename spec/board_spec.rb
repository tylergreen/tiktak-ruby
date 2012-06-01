require 'minitest/spec'
require 'minitest/autorun'
require 'board'

describe Board do
  before do
    @board = Board.new(3)
  end
  
  describe "board functionality" do
    it "is empty when created" do
      assert_equal(@board.to_a, [:empty].cycle(@board.size).to_a())
    end
    
    it "knows if a spot is available" do
      (0...@board.size).each do |pos|
        assert @board.available?(pos)        
      end
    end

    it "knows if a move is legal" do
      assert( not(@board.legal_move?(-1)), "failed for negative numbers not allowed")
      assert( not(@board.legal_move?(@board.size)), "off by one")
      (0...@board.size).each do |pos|
        assert(@board.legal_move?(pos), "failed for #{pos}")        
      end
      assert not(@board.place(:x,0).legal_move?(0))

    end

    it "can have pieces placed on it" do 
      assert not(@board.place(:x,0).legal_move?(0))
      assert([:x, :o, :empty], @board.place(:x,0).place(:o,3).rows.first )
    end

    it "provides access to rows" do
      assert_equal([[:empty, :empty, :empty]].cycle(@board.length).to_a, @board.rows)
      assert([:x, :o, :empty], @board.place(:x,3).place(:o,4).rows[2] )
    end
    
    it "provides access to columns" do
      assert_equal([[:empty, :empty, :empty]].cycle(@board.length).to_a, @board.columns)
      assert_equal([:x, :o, :x], @board.place(:x, 0).place(:o, 3).place(:x, 6).columns.first)
      assert_equal([:x, :o, :x], @board.place(:x, 1).place(:o, 4).place(:x, 7).columns[1])
    end
  end

  it "provides access to its diagonals" do
    assert_equal([[:x, :x, :empty], [:empty, :x, :o]],
                 @board.place(:x, 0).place(:x, 4).place(:o, 6).diagonals)
  end

  it "can detect a winner" do
    assert( not(@board.winner?), "false positive")
    assert_equal(:x, @board.place(:x,0).place(:x,1).place(:x,2).winner?, "failed to detect row win")
    assert_equal(:o, @board.place(:o,2).place(:o,4).place(:o,6).winner?, "failed to detect diagonal win")
    assert_equal(:o, @board.place(:o,1).place(:o,4).place(:o,7).winner?, "failed to detect column win")
  end

  it "can have a predefined layout" do
    assert_equal([:x, :x, :o, :o, :o, :x, :x , :o, :o],
                 Board.new(3, [:x, :x, :o, :o, :o, :x, :x , :o, :o]).to_a)
  end

   it "can format itself to look prettier" do
    assert_equal([["_"].cycle(@board.length).to_a].cycle(@board.length).to_a, @board.format)
  end
  


end

    
    
  
  

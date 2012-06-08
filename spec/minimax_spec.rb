require 'minitest/spec'
require 'minitest/autorun'
require 'game'
require 'players/minimax/minimax'

describe Minimax do
  before do
    @tie_board = Board.new(3, [:x, :x, :o,
                               :o, :o, :x,
                               :x, :x, :o])
    @x_win_board = Board.new(3, [:x, :x, :x, 
                                 :o, :o, :empty,
                                 :empty, :empty, :empty])
    @o_win_board = Board.new(3, [:x, :x, :o, 
                                  :x, :o, :empty,
                                 :o, :empty, :empty])
    @move7_board = Board.new(3, [:x, :x, :o, 
                                  :x, :o, :x,
                                 :o, :empty, :empty])
    @empty_board = Board.new(3)
  end

  describe "MiniMax API" do
    
    it "knows the value of a terminal position" do
      assert_equal(0, Minimax.value(@tie_board))
      assert_equal(1, Minimax.value(@x_win_board))
      assert_equal(-1, Minimax.value(@o_win_board))
    end

    it "can generate all the successors to a given board state" do
      assert_equal([], Minimax.successors(@tie_board))
      assert_equal(@empty_board.size, Minimax.successors(@empty_board).length)
      assert_equal( [[:x, :x, :o, 
                      :x, :o, :o,
                      :o, :x, :x]],
                    Minimax.successors(Board.new(3,[:x, :x, :o, 
                                                    :x, :o, :o,
                                                    :o, :x, :empty])))
                    


    end

  end
end

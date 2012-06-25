require 'minitest/spec'
require 'minitest/autorun'
require 'game'
require 'players/minimax/minimax'
require 'players/minimax/minimax_ai'

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
      assert_equal(0, Minimax.value(@tie_board,:x))
      assert_equal(0, Minimax.value(@tie_board,:o))
      assert_equal(1, Minimax.value(@x_win_board, :x))
      assert_equal(-1, Minimax.value(@o_win_board, :x))
      assert_equal(-1, Minimax.value(@x_win_board, :o))
      assert_equal(1, Minimax.value(@o_win_board, :o))
    end

    it "plays moves that lead to victory" do
      assert_equal(2, Minimax.minimax(:x, Board.new(3, [:x, :x, :empty,
                                                        :x, :o, :o,
                                                        :o, :x, :o])))
      assert_equal(2, Minimax.minimax(:x, Board.new(3, [:x, :x, :empty,
                                                        :o, :empty, :o,
                                                        :empty, :empty, :empty]))) 
      assert_equal(6, Minimax.minimax(:o, Board.new(3, [:o, :x, :empty,
                                                       :o, :x, :empty,
                                                       :empty, :empty, :empty])))
      assert_equal(7, Minimax.minimax(:o, Board.new(3, [:empty, :x, :empty,
                                                        :o, :x, :empty,
                                                        :empty, :empty, :o])))
    end

    it "rates" do 
      assert_equal(-1, Minimax.move_value(:x, 1, Board.new(3, [:x, :empty, :o,
                                                           :empty, :x, :empty,
                                                           :empty, :empty, :o])))
      assert_equal(0, Minimax.move_value(:x, 5, Board.new(3, [:empty, :x, :o,
                                                           :o,    :x,  :empty,
                                                           :empty, :empty, :o])))

    end

    it "as o it blocks x vertically" do
      assert_equal(7, Minimax.minimax(:o, Board.new(3, [:empty, :x, :empty,
                                                        :empty, :x, :empty,
                                                        :empty, :empty, :o])))
    end

    it "as o it blocks x horizontally" do
      assert_equal(7, Minimax.minimax(:o, Board.new(3, [:empty, :x, :empty,
                                                        :empty, :x, :empty,
                                                        :empty, :empty, :o])))
    end

    it "as o it blocks x diagonally" do
      assert_equal(6, Minimax.minimax(:o, Board.new(3, [:empty, :empty, :x,
                                                        :empty, :x, :empty,
                                                        :empty, :empty, :o])))
    end

    it "x blocks o vertically" do
      assert_equal(-1, Minimax.move_value(:x, 8, Board.new(3, [:x, :o, :empty,
                                                        :x, :o, :empty,
                                                        :empty, :empty, :empty])))
    end

    it "o block horizontally" do
      assert_equal(2, Minimax.minimax(:o, Board.new(3, [:x, :x, :empty,
                                                        :o, :empty, :empty,
                                                        :empty, :empty, :empty])))
    end

    it "a win for x if bad for o" do
      assert_equal(-1, Minimax.move_value(:o, 4, Board.new(3, [:x, :x, :empty,
                                                            :o, :empty, :empty,
                                                            :empty, :empty, :empty])))
    end

    it "any move is bad when you are forked" do
      assert_equal(-1, Minimax.move_value(:o, 1, Board.new(3, [:x, :empty, :x,
                                                            :o, :x, :empty,
                                                            :empty, :empty, :empty])))
    end


    it "o block horizontally 2" do
      assert_equal(4, Minimax.minimax(:o, Board.new(3, [:empty, :o, :empty,
                                                        :x, :empty, :x,
                                                        :empty, :empty, :empty])))
    end



    it "o doesn't let itself get forked'" do
      assert_equal(4, Minimax.minimax(:o, Board.new(3, [:x, :empty, :empty,
                                                        :empty, :empty, :empty,
                                                     :empty, :empty, :empty])))
    end

   it "o values boards" do
      assert_equal(-1, Minimax.move_value(:o, 2, Board.new(3, [:x, :empty, :empty,
                                                           :o, :x, :empty,
                                                           :empty, :empty, :empty])))
    end

   it "o values boards 3" do
      assert_equal(0, Minimax.move_value(:o, 8, Board.new(3, [:x, :o, :empty,
                                                           :o, :x, :empty,
                                                           :empty, :empty, :empty])))
    end



    it "o blocks vertically" do
      assert_equal(7, Minimax.minimax(:o, Board.new(3, [:empty, :x, :empty,
                                                        :empty, :x, :empty,
                                                        :empty, :empty, :o])))
    end
    
    it "x blocks horizontally for win" do
      assert_equal(7, Minimax.minimax(:x, Board.new(3, [:empty, :x, :empty,
                                                        :empty, :x, :empty,
                                                        :o, :empty, :o])))
    end

    it "only searches n moves deep" do
      assert_equal(0, Minimax.move_value(:x, 0, Board.new(4), true, 0))
      assert_equal(0, Minimax.move_value(:x, 0, Board.new(4), true, 3))
    end

    it "always ties itself" do
#      g = Game.new(3, MinimaxAI.new(:x), MinimaxAI.new(:o))
#     assert_equal("Tie Game!", g.start)
    end
  end
end

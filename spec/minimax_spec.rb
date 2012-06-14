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
      assert_equal(0, Minimax.value(@tie_board,:x))
      assert_equal(0, Minimax.value(@tie_board,:o))
      assert_equal(1, Minimax.value(@x_win_board, :x))
      assert_equal(-1, Minimax.value(@o_win_board, :x))
      assert_equal(-1, Minimax.value(@x_win_board, :o))
      assert_equal(1, Minimax.value(@o_win_board, :o))
    end

    it "plays moves that lead inevitably to victory" do
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
      assert_equal(-1, Minimax.value_for(:x, Board.new(3, [:x, :x, :o,
                                                        :empty, :x, :empty,
                                                           :empty, :empty, :o])))
      assert_equal(0, Minimax.value_for(:x, Board.new(3, [:empty, :x, :o,
                                                           :o,    :x,  :x,
                                                           :empty, :empty, :o])))

    end

    it "as o it blocks x vertically" do
      assert_equal(7, Minimax.minimax(:o, Board.new(3, [:empty, :x, :empty,
                                                        :o, :x, :x,
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
      assert_equal(-1, Minimax.value_for(:x, Board.new(3, [:x, :o, :empty,
                                                        :x, :o, :empty,
                                                        :empty, :empty, :x])))
    end

    it "o block horizontally" do
      assert_equal(2, Minimax.minimax(:o, Board.new(3, [:x, :x, :empty,
                                                        :o, :empty, :empty,
                                                        :empty, :empty, :empty])))
    end

    it "a win for x if bad for o" do
      assert_equal(-1, Minimax.value_for(:o, Board.new(3, [:x, :x, :x,
                                                            :o, :empty, :empty,
                                                            :empty, :empty, :empty])))
    end

    it "a win for x if bad for o" do
      assert_equal(-1, Minimax.value_for(:o, Board.new(3, [:x, :empty, :x,
                                                            :o, :x, :empty,
                                                            :empty, :empty, :empty])))
    end

    it "forks are winning position for x" do
      assert_equal(1, Minimax.value_for(:x, Board.new(3, [:x, :empty, :x,
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
      assert_equal(-1, Minimax.value_for(:o, Board.new(3, [:x, :o, :empty,
                                                           :o, :x, :empty,
                                                           :empty, :empty, :empty])))
    end

   it "o values boards 3" do
      assert_equal(0, Minimax.value_for(:o, Board.new(3, [:x, :o, :empty,
                                                           :o, :x, :empty,
                                                           :empty, :empty, :o])))
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

b = Board.new(3, [:x, :o, :x, 
                  :o, :empty, :empty, 
                  :empty, :empty, :x])


      

  end
end

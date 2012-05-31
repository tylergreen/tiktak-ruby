require 'minitest/spec'
require 'minitest/autorun'
require 'board'

describe Board do
  describe "board functionality" do
    it "is empty when created" do
      assert_equal(Board.new.to_a, [:empty].cycle(9).to_a())
    end
    
    it "knows if a spot is available" do
      assert Board.new.available?(rand(9))
    end

    it "knows if a move is legal" do
      assert Board.new.legal_move?(0)
    end

    it "can have pieces placed on it" do 
      # Board.new.place()      
    end
  end
end
    
    
  
  

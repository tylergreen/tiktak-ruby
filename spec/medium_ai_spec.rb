require 'minitest/autorun'
require 'minitest/spec'
require 'players/medium_ai'

describe MediumAI do
  before do
    @medium_x = MediumAI.new(:x)
    @medium_o = MediumAI.new(:x)
  end

  it "looks ahead one move" do
    assert(4, @medium_x.get_move( Board.new(3, [:empty, :x, :empty,
                                                  :empty, :empty, :o,
                                                  :o, :x, :empty])))
    assert(4, @medium_o.get_move( Board.new(3, [:empty, :x, :empty,
                                                  :empty, :empty, :o,
                                                  :empty, :x, :empty])))
  end
  
end

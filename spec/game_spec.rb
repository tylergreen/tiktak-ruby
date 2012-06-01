require 'minitest/spec'
require 'minitest/autorun'
require 'game'
require 'human'

describe Game do
  before do
    @player_x  = Human.new
    @player_y  = Human.new
    @game = Game.new(3, @player_x, @player_y)
  end

  describe "Game Functionality" do

    it "can switch back and forth between two players" do
      assert_equal(@player_x, @game.switch(@player_y))
      assert_equal(@player_y, @game.switch(@player_x))
    end

    it "knows its size" do
      assert_equal(9, Game.new(3, nil, nil).size)
      assert_equal(16, Game.new(4, nil, nil).size)
    end
    
    it "validates player input" do 
      (0...@game.size).each do |position|
        input = position.to_s
        assert(@game.valid_input?(input), "failed to validate good input: #{input}")
      end
      [":45", "[3m", " ", "monkey", "", "&sfd", "\n" ].each do |input|
        assert(not(@game.valid_input?(input)), "validated bad input: #{input}")
      end


    end
  end
end    



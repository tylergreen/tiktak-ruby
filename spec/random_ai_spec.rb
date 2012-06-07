require 'minitest/spec'
require 'minitest/autorun'
require 'game'
require 'players/mock_player'
require 'players/random_ai'


describe RandomAI do
  before do
    @random = RandomAI.new
    @game = Game.new(3, nil, nil)
  end

  describe "Random AI" do
    it "won't select and illegal space" do 
      assert((0...9).include?(@random.get_move(Board.new(3))))
      assert((0..2).include?(@random.get_move(Board.new(3, [:empty, :empty, :empty, :x, :o, :x, :o, :x, :o]))))
    end
    
    it "can play a game" do
      assert(Game.new(3, RandomAI.new, RandomAI.new).start)
    end
  end

end

require 'minitest/spec'
require 'minitest/autorun'
require 'tiktak/game'
require 'tiktak/players/mock_player'
require 'tiktak/players/random_ai'


describe RandomAI do
  before do
    @random = RandomAI.new
    @game = Game.new(3, RandomAI, RandomAI)
  end

  describe "Random AI" do
    it "won't select and illegal space" do 
      assert((0...9).include?(@random.get_move(Board.new(3))))
      assert((0..2).include?(@random.get_move(Board.new(3, [:empty, :empty, :empty, :x, :o, :x, :o, :x, :o]))))
    end
    
  end

end

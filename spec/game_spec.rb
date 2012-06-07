require 'minitest/spec'
require 'minitest/autorun'
require 'game'
require 'human'
require 'mock_player'

describe Game do
  before do
    @game = Game.new(3, nil, nil)
  end

  describe "Game Functionality" do

    it "knows its size" do
      assert_equal(9, Game.new(3, nil, nil).size)
      assert_equal(16, Game.new(4, nil, nil).size)
    end

    it "keeps asking for input until it gets a valid and legal move" do
      assert(2, @game.get_move( MockPlayer.new(["100", "monkey", "2"])))
      assert(5, @game.get_move( MockPlayer.new(["jibberish", "5y", "5"])))
      assert(0, @game.get_move( MockPlayer.new(["  7 ", "0", "5"])))
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

    it "has a turn sequence" do 
      assert_equal([[:x, @player1],
                    [:o, @player2],
                    [:x, @player1]], @game.turns.take(3))
      assert_equal(9, @game.turns.length)
    end

    it "can be started and played" do
      assert_equal("Player x wins!",
                   Game.new(3,
                            MockPlayer.new(%w[0 1 2 ]),
                            MockPlayer.new(%w[ 6 4 8])).start) 
      
      assert_equal("Player o wins!",
                   Game.new(3,
                            MockPlayer.new(%w[0 4 2 ]),
                            MockPlayer.new(%w[ 6 7 8 ])).start)
      assert_equal("Tie Game!", 
                   Game.new(3,
                            MockPlayer.new(%w[ 2 3 4 7 8 ]),
                            MockPlayer.new(%w[ 0 1 5 6])).start)

    end
  end
end    



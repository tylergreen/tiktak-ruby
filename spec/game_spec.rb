require 'minitest/spec'
require 'minitest/autorun'
require 'tiktak/game'
require 'tiktak/players/mock_player'
require 'tiktak/frontends'

describe Game do
  before do
    @game = Game.new(3)
  end

  describe "Game Functionality" do

    # it "keeps asking for input until it gets a valid and legal move" do
    #   assert(2, @game.get_move( MockPlayer.new(["100", "monkey", "2"])))
    #   assert(5, @game.get_move( MockPlayer.new(["jibberish", "5y", "5"])))
    #   assert(0, @game.get_move( MockPlayer.new(["  7 ", "0", "5"])))
    # end
    
    it "validates player input" do 
      (0...@game.board.size).each do |position|
        assert(@game.valid_input?(position), "failed to validate good input: #{position}")
      end
      [":45", "[3m", " ", "monkey", "", "&sfd", "\n" ].each do |input|
        assert(!(@game.valid_input?(input)), "validated bad input: #{input}")
      end
    end

    it "can be started and played" do
      # assert_equal(:x,
      #              Game.new(3,
      #                       MockPlayer.new(%w[0 1 2 ]),
      #                       MockPlayer.new(%w[ 6 4 8])).play) 
      
      # assert_equal(:o,
      #              Game.new(3,
      #                       MockPlayer.new(%w[0 4 2 ]),
      #                       MockPlayer.new(%w[ 6 7 8 ])).play)
      # assert_equal("Tie Game!", 
      #              Game.new(3,
      #                       MockPlayer.new(%w[ 2 3 4 7 8 ]),
      #                       MockPlayer.new(%w[ 0 1 5 6])).play)

    end

    it "is not running until it is started" do
      assert_equal(false, @game.running)
      @game.start
      assert(@game.running)
    end

    it "can be told to make a move" do
      @game.start
      assert_equal(:ok, @game.make_move(:x, 0) )
      assert_equal('bad move: 0', @game.make_move(:x, 0) )
    end

    it "knows the current player" do
      assert_equal(:x, @game.start.current_player)
      assert_equal(:o, @game.next_player)
      assert_equal(:o, @game.current_player)
    end

  end    
end    



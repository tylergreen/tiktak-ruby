require 'minitest/spec'
require 'minitest/autorun'
require 'block_rule_board'
require 'players/random_ai'

describe BlockRuleBoard do

  it "can detect a block winner" do
    assert_equal(:x, BlockRuleBoard.new(3, [:x, :x, :o,
                                   :x, :x, :o,
                                   :o, :o, :empty]).winner?)
    assert_equal(:x, BlockRuleBoard.new(4, [:x, :x, :o, :empty,
                                   :x, :x, :o,:empty,
                                   :o, :o, :empty, :empty,
                                   :empty, :empty, :o, :empty,
                                  ]).winner?)
  end

  it "provides an interface to all the 2x2 blocks on the board" do
    assert_equal(4, BlockRuleBoard.new(3).blocks.length)
    assert_equal([:x, :empty, :empty, :x], BlockRuleBoard.new(3).place(:x, 0).place(:x, 4).blocks.first)
    assert_equal([:x, :x, :x, :x], BlockRuleBoard.new(4).place(:x, 0).place(:x, 1).place(:x, 4).place(:x, 5).blocks.first)
  end


end

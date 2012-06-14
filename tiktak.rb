require 'game'
require 'players/human'
require 'players/random_ai'
require 'players/minimax/minimax_ai'


def get_player(str) 
  case str
    when "human" 
    Human
    when "random"
    RandomAI
    when "unbeatable"
    MinimaxAI
  else raise "unknown player type"
  end
end

g = Game.new(3, get_player(ARGV[0]).new(:x), get_player(ARGV[1]).new(:o))
g.start

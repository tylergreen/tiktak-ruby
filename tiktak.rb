require 'game'
require 'players/human'
require 'players/random_ai'



g = Game.new(3, Human.new, RandomAI.new)
g.start

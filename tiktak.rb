require 'game'
require 'option'
require 'players/human'
require 'players/random_ai'
require 'players/minimax/minimax_ai'
require 'YAML'

module TikTak

  Players = Option.new({ 'human' => Human,
                          'weak' => RandomAI,
                          'unbeateable' => MinimaxAI
                        })

  Board_sizes = Option.new({ '3x3' => 3,
                             '4x4'=> 4
                           })

  Rules = Option.new({ 'normal rules' => false,
                       'block rules (2x2 square of pieces counts as win)' => true    
                     })

  def self.main
    puts "Welcome to Tyler's Tik Tak To Game!"
    player1 = Players.prompt("select first player:"){ STDIN.readline}.new(:x)
    player2 = Players.prompt("select second player:"){ STDIN.readline}.new(:o)
    game_size = Board_sizes.prompt("select game size:"){ STDIN.readline }
    block_win = Rules.prompt("select rules:"){ STDIN.readline}
    game = Game.new(game_size, player1, player2, block_win)
    result = game.play
    game.board.print
    puts result
    puts "Thanks for playing!"
  end
end

TikTak.main

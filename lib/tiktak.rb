require 'tiktak/game'
require 'tiktak/option'
require 'tiktak/prompt'
require 'tiktak/frontends'
require 'tiktak/players/human'
require 'tiktak/players/random_ai'
require 'tiktak/players/medium_ai'
require 'tiktak/players/tcp_player'
require 'tiktak/players/minimax/minimax_ai'

module TikTak

  Players = Option.new({ 'human' => Human,
                          'weak' => RandomAI,
                         'barely smart' => MediumAI,
                          'unbeateable' => MinimaxAI
                        })

  Board_sizes = Option.new({ '3x3' => 3,
                             '4x4'=> 4
                           })

  Rules = Option.new({ 'normal rules' => false,
                       'block rules (2x2 square of pieces counts as win)' => true    
                     })

  def self.gui
    game_size = 3
    player1 = TCP_Player.new(:x)
    player2 = TCP_Player.new(:o)
    block_win = false
    game = Game.new(game_size, player1, player2, block_win, TCP_Display.new)
    game.play
    puts "starting gui game"
    puts "thanks for playing!"
  end

  def self.main
    puts "Welcome to Tyler's Tik Tak To Game!"
    std = Prompt.new(STDIN, STDOUT)
    player1 = std.prompt("select first player:\n" + Players.to_s){ |input| Players.select(input) }.first.new(:x)
    player2 = std.prompt("select second player:\n" + Players.to_s){ |input| Players.select(input) }.first.new(:o)
    game_size = std.prompt("select game size:\n" + Board_sizes.to_s){ |input| Board_sizes.select(input) }.first
    block_win = std.prompt("select rules:\n" + Rules.to_s){ |input| Rules.select(input)}.first
    game = Game.new(game_size, player1, player2, block_win, CL_Display.new)
    game.play 
 end
end


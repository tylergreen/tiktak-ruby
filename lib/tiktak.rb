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

  def self.select_player(player_code)
    case player_code
    when 'human'
      TCP_Player.new(:x)
    when 'weak'
      RandomAI.new(:x)
    when 'medium'
      MediumAI.new(:o)
    when 'hard'
      MinimaxAI.new(:o)
    else
      raise "unknown Player type: #{player_code}"
    end
  end

  def self.gui(player1_code, player2_code)
    game_size = 3

    player1 = select_player(player1_code)
    player2 = select_player(player2_code)
    
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


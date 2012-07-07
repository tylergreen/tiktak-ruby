require 'tiktak/game'
require 'tiktak/players/human'
require 'tiktak/players/random_ai'
require 'tiktak/players/medium_ai'
require 'tiktak/players/tcp_player'
require 'tiktak/players/minimax/minimax_ai'
require 'tiktak/text_client/text_client'

module TikTak

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
    client = TextClient.new(STDIN, STDOUT)
    client.start
 end
end


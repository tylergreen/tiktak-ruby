require 'tiktak/text_client/prompt'
require 'tiktak/text_client/option'

require 'tiktak/game'

require 'tiktak/players/human'
require 'tiktak/players/random_ai'
require 'tiktak/players/medium_ai'
require 'tiktak/players/minimax/minimax_ai'
require 'tiktak/text_client/text_client'

class TextClient

  def initialize(stdin, stdout)
    @std = Prompt.new(stdin, stdout)
  end

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

  def show(board)
    puts board.to_s
    puts ''
  end

  def start
    puts "Welcome to Tyler's Tik Tak To Game!"
    player1 = @std.prompt("select first player:\n" + Players.to_s){ |input| Players.select(input) }.first
    player2 = @std.prompt("select second player:\n" + Players.to_s){ |input| Players.select(input) }.first
    game_size = @std.prompt("select game size:\n" + Board_sizes.to_s){ |input| Board_sizes.select(input) }.first
    block_win = @std.prompt("select rules:\n" + Rules.to_s){ |input| Rules.select(input)}.first
    @player1 = player1.new(:x)
    @player2 = player2.new(:o)
    @game = Game.new(game_size, block_win)
    @game.start
    game_loop
  end

  def game_loop
    turns = [[:x, @player1], [:o, @player2]].cycle.take(@game.board.size)
    show(@game.board)
    @result = turns.find( lambda{[ "Tie Game!"]} ) do |mark, player|
      move = player.get_move(@game.board)
      @game.make_move(mark, move)
      show(@game.board)
      @game.board.winner?
    end.first
  end

end

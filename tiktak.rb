require 'game'
require 'players/human'
require 'players/random_ai'
require 'players/minimax/minimax_ai'

module TikTak

  def self.players
    [['0', "Human", Human],
     ['1', "Weak" , RandomAI],
     ['2', "Unbeatable" , MinimaxAI]
    ]
  end

  def self.game_sizes
    [['3', '3x3', 3],
     ['4', '4x4', 4]]
  end
  
  def self.rules
    [['0', 'normal rules', false],
     ['1', 'use block win rule (2x2 square of pieces counts as win)', true]]
  end
  
  # needs major cleanup
  def self.select_option(msg, options)
    puts msg
    options.each do |option|
      puts option.take(2).join(' => ')
    end
    verification = Regexp.new("^#{options.map(&:first).join('|')}$")
    begin
      input = STDIN.read(1)
    end until input =~ verification
    option = options.find(){ |opt| input[0] == opt[0]} 
    raise "not an option: #{input}" unless option
    option[2]
  end

  def self.greet
    puts "Welcome!"
    player1 = select_option("select first player:", players).new(:x)
    player2 = select_option("select second player:", players).new(:o)
    game_size = select_option("select game size:",  game_sizes)
    block_win = select_option("select rules:", rules)
    result = Game.new(game_size, player1, player2, block_win).play
    puts result
    puts "Thanks for playing!"
  end
end


# g = Game.new(ARGV[2].to_i, get_player(ARGV[0]).new(:x), get_player(ARGV[1]).new(:o))
TikTak.greet

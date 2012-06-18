require 'minitest/spec'
require 'minitest/autorun'
require 'board'
require 'players/random_ai'

describe Board do
  before do
    @empty_board = Board.new(3)
    @tie_board = Board.new(3, [:x, :x, :o,
                               :o, :o, :x,
                               :x, :x, :o])
    @x_win_board = Board.new(3, [:x, :x, :x, 
                                 :o, :o, :empty,
                                 :empty, :empty, :empty])
    @o_win_board = Board.new(3, [:x, :x, :o, 
                                 :x, :o, :empty,
                                 :o, :empty, :empty])
    @incomplete_board = Board.new(3, [:empty, :x, :o, 
                                      :empty, :o, :empty,
                                      :empty, :x, :empty])
    @four_board = Board.new(4)
  end
  
  describe "board api" do
    it "has all empty spots when created" do
      assert_equal(@empty_board.to_a, [:empty].cycle(@empty_board.size).to_a())
      assert_equal(Board.new(3).to_a, [:empty].cycle(9).to_a())
      assert_equal(Board.new(4).to_a, [:empty].cycle(16).to_a())
    end
    
    it "knows if a specific position is available" do
      (0...@empty_board.size).each do |pos|
        assert @empty_board.available?(pos)        
      end
    end
    
    it "knows its available positions" do
      assert_equal((0...@empty_board.size).to_a, @empty_board.available_moves)
      assert(not(@empty_board.available_moves.include?(9) ))
      assert_equal(@empty_board.size, @empty_board.available_moves.length)
      assert_equal((0..7).to_a, @empty_board.place(:x, 8).available_moves)
      assert_equal((1..7).to_a, @empty_board.place(:x,0).place(:o,8).available_moves)
      assert_equal([3,4,5], Board.new(3,[:x,:x,:o,:empty, :empty, :empty, :o, :x, :o]).available_moves)
      assert_equal([], @tie_board.available_moves)
  end


    it "knows if a move is legal" do
      assert( not(@empty_board.legal_move?(-1)), "allowed negative number as move")
      assert( not(@empty_board.legal_move?(@empty_board.size)), "off by one")
      (0...@empty_board.size).each do |pos|
        assert(@empty_board.legal_move?(pos), "failed for #{pos}")        
      end
      assert not(@empty_board.place(:x,0).legal_move?(0))
    end

    it "can have pieces placed on it" do 
      assert not(@empty_board.place(:x,0).legal_move?(0))
      assert([:x, :o, :empty], @empty_board.place(:x,0).place(:o,3).rows.first )
    end

    it "can clone itself and place a piece on the clone" do
      clone = @empty_board.clone_and_place(:x, 0)
      assert_equal([:empty, :empty, :empty], @empty_board.rows.first)
      assert_equal([:x, :empty,:empty], clone.rows.first)

      clone2 = @empty_board.clone_and_place(:x, 0)
      @empty_board.place(:x, 0)
      assert_equal(@empty_board.to_a, clone2.to_a)
      assert(not( @empty_board == clone2))
    end

    it "provides access to rows" do
      assert_equal([[:empty, :empty, :empty]].cycle(3).to_a,
                   @empty_board.rows)
      assert_equal([[:empty, :empty,:empty],
                    [:x, :o, :empty],
                    [:empty, :empty, :empty]],
              @empty_board.place(:x,3).place(:o,4).rows )
      assert_equal([:x, :o, :empty], @empty_board.place(:x,3).place(:o,4).rows[1] )
      assert_equal([:x, :o, :empty], @empty_board.place(:x,6).place(:o,7).rows[2] )
    end
    
    it "rows can be arbitrarily long" do
      board4 = Board.new(4)
      assert(board4.rows.all? { |row| row.length == board4.length})
    end
    
    it "provides access to columns" do
      assert_equal([[:empty, :empty, :empty]].cycle(@empty_board.length).to_a, @empty_board.columns)
      assert_equal([:x, :o, :x], @empty_board.place(:x, 0).place(:o, 3).place(:x, 6).columns.first)
      assert_equal([:x, :o, :x], @empty_board.place(:x, 1).place(:o, 4).place(:x, 7).columns[1])
    end

    it "can handle arbitrarily sized coluns" do
      board4 = Board.new(4)
      assert(board4.columns.all? { |col| col.length == board4.length})
    end
  end

  it "provides access to its diagonals" do
    assert_equal([[:x, :x, :empty], [:empty, :x, :o]],
                 @empty_board.place(:x, 0).place(:x, 4).place(:o, 6).diagonals)
    assert_equal([[:empty, :x, :o], [:x, :x, :empty]],
                 Board.new(3).place(:x, 2).place(:x, 4).place(:o, 8).diagonals)
  end

  it "provides access to diagonals on 4x4 boards" do
    board4 = Board.new(4)
    assert(board4.rows.all? { |row| row.length == board4.length})
  end

  it "returns nil if no winner" do
    assert_equal(nil, Board.new(4).winner?)
  end

  it "can detect a winner" do
    assert( not(@empty_board.winner?), "false positive")
    assert_equal(:x, @empty_board.place(:x,0).place(:x,1).place(:x,2).winner?, "failed to detect row win")
    assert_equal(:o, @empty_board.place(:o,2).place(:o,4).place(:o,6).winner?, "failed to detect diagonal win")
    assert_equal(:o, @empty_board.place(:o,0).place(:o,4).place(:o,8).winner?, "failed to detect diagonal win")
    assert_equal(:o, @empty_board.place(:o,1).place(:o,4).place(:o,7).winner?, "failed to detect column win")
  end

  it "detects a win on 4x4 board" do
    assert_equal(:o, Board.new(4).place(:o,1).place(:o,5).place(:o,9).place(:o,13).winner?)
  end

  it "knows when the game is in a terminal position" do
    assert(not(Board.new(3).terminal?))
    assert(not(Board.new(3).place(:x, 4).terminal?))
    assert(Board.new(3, ))

    g = Game.new(3, RandomAI.new, RandomAI.new)
    g.start
    assert(g.board.terminal?)
  end

  it "can have a predefined layout" do
    assert_equal([:x, :x, :o, :o, :o, :x, :x , :o, :o],
                 Board.new(3, [:x, :x, :o, :o, :o, :x, :x , :o, :o]).to_a)
  end

   it "can format itself to look prettier" do
    assert_equal([["_"].cycle(@empty_board.length).to_a].cycle(@empty_board.length).to_a, @empty_board.format)
  end

  


end

    
    
  
  

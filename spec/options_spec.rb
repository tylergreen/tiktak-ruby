require 'minitest/autorun'
require 'minitest/spec'
require 'option'
require 'stringio'

describe Option do
  class Lion
  end
  class Tiger
  end
  
  before do
    input = StringIO.new("monkey\nwoeu\n0\n", 'r')
    output = StringIO.new

    @option = Option.new({'snake' => :snake, 'rabbit' => :rabbit}, input, output )

  end

  it "does classes" do
    input = StringIO.new("monkey\n7\n0\n", 'r')
    output = StringIO.new

    cats = Option.new({ 'tiger' => Tiger,
                          'lion' => RandomAI
                        }, input, output)
    assert(Tiger, cats.prompt("pick"))
  end

  # it "presents options, waits for input, and returns something based on the input" do
  #   assert_equal("0 => snake\n1 => rabbit", @option.to_s)
  # end

  # it "lets you select with numbers" do
  #   assert_equal(:snake, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(0))
  #   assert_equal(:rabbit, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(1))
  #   assert_equal(:invalid_option, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(2))
  # end
  
  # it "prompts for a selection, which must be valid" do
  #   inputs = ['monkey', '10', '0']
  #   assert_equal(:snake, @option.prompt(''){ inputs.shift })
  #   assert_equal(:rabbit, @option.prompt(''){ '1' })
  #   assert_equal(:rabbit, @option.prompt(''){ "1\n" })
  # end

  it "prompts for a choice" do
    assert_equal(:snake, @option.prompt("select animal"))
  end

  it "prompts for a choice" do
    assert_equal(:snake, @option.prompt("select animal"))
  end


end

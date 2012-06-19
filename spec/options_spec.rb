require 'minitest/autorun'
require 'minitest/spec'
require 'option'
require 'stringio'

describe Option do
  before do
    @option = Option.new({'snake' => :snake, 'rabbit' => :rabbit}, StringIO.new)
  end

  it "presents options, waits for input, and returns something based on the input" do
    assert_equal("0 => snake\n1 => rabbit", @option.to_s)
  end

  it "lets you select with numbers" do
    assert_equal(:snake, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(0))
    assert_equal(:rabbit, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(1))
    assert_equal(:invalid_option, Option.new({'snake' => :snake, 'rabbit' => :rabbit}).select(2))
  end
  
  it "prompts for a selection, which must be valid" do
    inputs = ['monkey', '10', '0']
    assert_equal(:snake, @option.prompt(''){ inputs.shift })
    assert_equal(:rabbit, @option.prompt(''){ '1' })
    assert_equal(:rabbit, @option.prompt(''){ "1\n" })
  end


end

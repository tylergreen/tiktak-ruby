require 'minitest/autorun'
require 'minitest/spec'
require 'option'
require 'stringio'

describe Option do
  before do
    @option = Option.new({'snake' => :snake, 'rabbit' => :rabbit})
  end

  it "lets you select" do
    assert_equal([:snake], @option.select("0"))
    assert_equal([:snake], @option.select("0\n"))
    assert_equal([:rabbit], @option.select("1\n"))
    assert_equal(false, @option.select("bad input"))
  end

  it "supports options that are false" do
    option = Option.new({'turn off' => false, 'turn on' => true})
    assert_equal( [ false ] , option.select('0'))
    assert_equal(false, option.select('2'))
  end
             
  it "presents options, waits for input, and returns something based on the input" do
    assert_equal("0 => snake\n1 => rabbit", @option.to_s)
  end

end

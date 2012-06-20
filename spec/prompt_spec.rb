require 'minitest/autorun'
require 'minitest/spec'
require 'prompt'
require 'stringio'

describe Prompt do
  it "accepts input based on its parameters" do
    input = StringIO.new("10\n", 'r')
    output = StringIO.new
    assert_equal("10\n", Prompt.new(input,output).prompt("input 10"){ |x| x.to_i == 10 } )
  end
  
  it "keeps asking for a line of input until one satisfies the code block" do
    input = StringIO.new("monkey\n!@&@#\n12\n", 'r')
    output = StringIO.new
    assert_equal("12\n", Prompt.new(input,output).prompt("input number"){ |x| x =~ /^(\d+)$/})
  end

end

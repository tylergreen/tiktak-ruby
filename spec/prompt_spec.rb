require 'minitest/autorun'
require 'minitest/spec'
require 'tiktak/prompt'
require 'stringio'

describe Prompt do
  before do
    @p1 = Prompt.new(StringIO.new("monkey\ngiraffe\n0\n", 'r'), StringIO.new)
    @p2 = Prompt.new(StringIO.new("10\n", 'r'), StringIO.new)
  end
    
  it "accepts input based on its parameters" do
    assert_equal(true, @p2.prompt("input 10"){ |x| x.to_i == 10 } )
  end
  
  it "return the result of the code block" do
    h = {"giraffe\n" => 100}
    assert_equal(100, @p1.prompt("input number"){ |x| h[x]})
  end

  it "keeps asking" do
    assert_equal("anything monkey\n",  @p1.prompt("press anykey"){ |resp| "anything " + resp })
    assert_equal(true,  @p1.prompt("no monkeys"){ |resp| !( resp == "monkey" )})
  end

end

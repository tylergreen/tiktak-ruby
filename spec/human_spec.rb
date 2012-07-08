require 'minitest/spec'
require 'minitest/autorun'
require 'tiktak/players/human'

describe Human do
  before do
    @human = Human.new
  end

  describe "Human" do

    it "is not an AI" do
      assert(! @human.ai?)
    end
  end
  
end

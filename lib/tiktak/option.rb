class Option
  def initialize(options_hash)
    @options = options_hash
  end
  
  def to_s
    @options.keys.each_with_index.map do |k, i|
      "#{i} => #{k}"
    end.join("\n")
  end

  def select(str)
    if str =~ /^[0-9]+$/ 
      i = str.to_i
      if i >= 0 and i < @options.length 
        [@options.values[i]] ## wrap value in array to emulate haskell Maybe -- [false] is a valid selection
      else
        false
      end
    else
      false
    end
  end
  
end

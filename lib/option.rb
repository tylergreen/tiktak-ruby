class Option
  def initialize(options_hash, input=STDIN, output=STDOUT)
    @options = options_hash
    @input = input
    @output = output
  end
  
  def to_s
    @options.keys.each_with_index.map do |k, i|
      "#{i} => #{k}"
    end.join("\n")
  end

  def valid_input(str)
    str =~ /^[0-9]+$/
  end

  def select(i)
    if i >= 0 and i < @options.length 
      @options.values[i] 
    else
      :invalid_option
    end
  end

  def prompt(msg)
    @output.puts msg
    @output.puts self.to_s
    begin
      input = @input.readline
      selection = select(input.to_i)
      verified = valid_input(input) && (selection != :invalid_option)
      @output.puts "Try again, invalid choice: #{input}" unless verified
    end until verified
    selection
  end
  
end

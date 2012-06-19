class Option
  def initialize(options_hash, stdout=STDOUT)
    @options = options_hash
    @stdout = stdout
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
    @stdout.puts msg
    @stdout.puts self.to_s
    begin
      input = if block_given?
                yield
              else
                STDIN.readline
              end
      selection = select(input.to_i)
      verified = if valid_input(input) and selection != :invalid_option
                   true
                 else
                   @stdout.puts "invalid selection: #{input} Try again."
                   false
                 end
    end until verified
    selection
  end
  
end

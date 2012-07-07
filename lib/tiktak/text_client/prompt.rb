class Prompt
  def initialize(input, output)
    @input = input
    @output = output
  end

  def prompt(msg)
    begin
      @output.puts msg
      input = @input.readline
      valid_result = yield input
      @output.puts "Try again -- Invalid input: #{input}" unless valid_result
    end until valid_result
    valid_result
  end

  def prompt2(msg)
    input = nil
    [ lambda{ @input.readline } ].cycle.find do |reader|
      @output.puts msg
      input = reader.call
      yield input
    end
    input
  end
end



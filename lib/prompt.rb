class Prompt
  def initialize(input, output)
    @input = input
    @output = output
  end

  def prompt(msg)
    begin
      @output.puts msg
      input = @input.readline
      valid = yield input
    end until valid
    input
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



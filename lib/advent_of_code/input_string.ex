defmodule AdventOfCode.InputString do
  def to_io_stream(input) do
    {:ok, input_io} = StringIO.open(input)
    IO.stream(input_io, :line)
  end
end

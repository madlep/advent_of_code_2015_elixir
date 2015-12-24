defmodule AdventOfCode.InputString do
  def to_io_stream(input) do
    {:ok, input_io} = StringIO.open(input)
    IO.stream(input_io, :line)
  end

  def run(input, initial_state, parse_fn, execute_fn) do
    input
    |> to_io_stream
    |> Stream.map(parse_fn)
    |> Enum.reduce(initial_state, execute_fn)
  end
end

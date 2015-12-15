defmodule AdventOfCode do

  def day1_1(input), do: AdventOfCode.Parens.parse(input)

  def day1_2(input), do: AdventOfCode.Parens.find_floor_offset(input)

  def day2_1(input) do
    input
    |> string_stream_io
    |> AdventOfCode.Wrapping.calculate_wrapping_area
  end

  def day2_2(input) do
    input
    |> string_stream_io
    |> AdventOfCode.Wrapping.calculate_ribbon_length
  end

  def day3_1(input), do: AdventOfCode.Grid.count_visited_locations(input)

  def day3_2(input), do: AdventOfCode.Grid.count_visited_locations(input, 2)

  defp string_stream_io(input) do
    {:ok, input_io} = StringIO.open(input)
    IO.stream(input_io, :line)
  end
end

defmodule AdventOfCode.WrappingTest do
  use ExUnit.Case
  doctest AdventOfCode.Wrapping

  alias AdventOfCode.Wrapping, as: W

  test "calculates area of wrapping paper needed for presents" do
    input = """
2x3x4
1x1x10
    """
    {:ok, input_io} = StringIO.open(input)
    input_stream = IO.stream(input_io, :line)
    assert W.calculate_wrapping_area(input_stream) == 58 + 43
  end

  test "calculates ribbon length needed for presents" do
    input = """
2x3x4
1x1x10
    """
    {:ok, input_io} = StringIO.open(input)
    input_stream = IO.stream(input_io, :line)
    assert W.calculate_ribbon_length(input_stream) == 34 + 14
  end
end

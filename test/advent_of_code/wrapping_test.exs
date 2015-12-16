defmodule AdventOfCode.WrappingTest do
  use ExUnit.Case, async: true
  doctest AdventOfCode.Wrapping

  alias AdventOfCode.Wrapping, as: W

  test "calculates area of wrapping paper needed for presents" do
    input = """
2x3x4
1x1x10
    """
    assert W.calculate_wrapping_area(input) == 58 + 43
  end

  test "calculates ribbon length needed for presents" do
    input = """
2x3x4
1x1x10
    """
    assert W.calculate_ribbon_length(input) == 34 + 14
  end
end

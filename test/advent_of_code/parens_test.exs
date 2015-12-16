defmodule AdventOfCode.ParensTest do
  use ExUnit.Case, async: true
  doctest AdventOfCode.Parens

  alias AdventOfCode.Parens, as: P

  test "find_floor_offset" do
    assert P.find_floor_offset("", 0) == 0
    assert P.find_floor_offset("(", 1) == 1
    assert P.find_floor_offset("((()(()((", 4) == 6
    assert P.find_floor_offset("((()(()((", -1) == nil
  end
end

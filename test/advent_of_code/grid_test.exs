defmodule AdventOfCode.GridTest do
  use ExUnit.Case, async: true
  doctest AdventOfCode.Grid

  alias AdventOfCode.Grid, as: G

  test "count_visited_locations" do
    assert G.count_visited_locations(">") == 2
    assert G.count_visited_locations("^>v<") == 4
    assert G.count_visited_locations("^v^v^v^v^v") == 2
  end

  test "count_visited_locations with multiple visitors" do
    assert G.count_visited_locations("^v", 2) == 3
    assert G.count_visited_locations("^>v<", 2) == 3
    assert G.count_visited_locations("^v^v^v^v^v", 2) == 11
  end
end

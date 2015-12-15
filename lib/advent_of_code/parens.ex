defmodule AdventOfCode.Parens do
  @doc ~S"""

  given a binary string containing "(" and ")" characters, find out the level
  santa is on after following the directions.

  santa starts at level 0. "(" goes up one level. ")" goes down

  ## Examples

    iex> AdventOfCode.Parens.parse_level "("
    1

    iex> AdventOfCode.Parens.parse_level ")"
    -1

    iex> AdventOfCode.Parens.parse_level "(())"
    0

    iex> AdventOfCode.Parens.parse_level "()()"
    0

    iex> AdventOfCode.Parens.parse_level "((("
    3

    iex> AdventOfCode.Parens.parse_level "(()(()("
    3

    iex> AdventOfCode.Parens.parse_level "))((((("
    3

    iex> AdventOfCode.Parens.parse_level "())"
    -1

    iex> AdventOfCode.Parens.parse_level "))("
    -1

    iex> AdventOfCode.Parens.parse_level ")))"
    -3

    iex> AdventOfCode.Parens.parse_level ")())())"
    -3
  """
  def parse_level(parens), do: parse_level(parens, 0)
  defp parse_level(<<"">>, level), do: level
  defp parse_level(<<"(", t :: binary>>, level), do: parse_level(t, level + 1)
  defp parse_level(<<")", t :: binary>>, level), do: parse_level(t, level - 1)


  @doc ~S"""

  given a binary string containing "(" and ")" characters, find the offset in
  the string where santa arrives at a specified level

  santa starts at level 0. "(" goes up one level. ")" goes down
  """
  def find_floor_offset(_parens, 0), do: 0
  def find_floor_offset(parens, floor), do: find_floor_offset(parens, floor, 0, 0)
  defp find_floor_offset(_parens, target, target, offset), do: offset
  defp find_floor_offset(<<"">>, _target, _current, _offset), do: nil
  defp find_floor_offset(<<"(", t ::binary>>, target, current, offset), do: find_floor_offset(t, target, current + 1, offset + 1)
  defp find_floor_offset(<<")", t ::binary>>, target, current, offset), do: find_floor_offset(t, target, current - 1, offset + 1)
end

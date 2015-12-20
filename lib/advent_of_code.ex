defmodule AdventOfCode do

  @doc ~S"""
    iex> AdventOfCode.day1_1 "(()"
    1
  """
  def day1_1(input), do: AdventOfCode.Parens.parse_level(input)

  @doc ~S"""
    iex> AdventOfCode.day1_2 "((()(", 3
    3
  """
  def day1_2(input, floor \\ -1), do: AdventOfCode.Parens.find_floor_offset(input, floor)

  @doc ~S"""
    iex> AdventOfCode.day2_1("2x3x4\n1x1x10\n")
    101
  """
  def day2_1(input) do
    AdventOfCode.Wrapping.calculate_wrapping_area(input)
  end

  @doc ~S"""
    iex> AdventOfCode.day2_2("2x3x4\n1x1x10\n")
    48
  """
  def day2_2(input) do
    AdventOfCode.Wrapping.calculate_ribbon_length(input)
  end

  @doc ~S"""
    iex> AdventOfCode.day3_1("^>v<")
    4
  """
  def day3_1(input), do: AdventOfCode.Grid.count_visited_locations(input)

  @doc ~S"""
    iex> AdventOfCode.day3_2("^>v<")
    3
  """
  def day3_2(input), do: AdventOfCode.Grid.count_visited_locations(input, 2)

  # these are slow. uncomment to run doctest
  # @doc ~S"""
  #   iex> AdventOfCode.day4_1("abcdef")
  #   609043

  #   iex> AdventOfCode.day4_1("pqrstuv")
  #   1048970
  # """
  def day4_1(input), do: AdventOfCode.HashCollision.find_collision(input, 5)

  # @doc ~S"""
  # iex> AdventOfCode.day4_2("abcdef")
  # 6742839
  # """
  def day4_2(input), do: AdventOfCode.HashCollision.find_collision(input, 6)

  @doc ~S"""
    iex> AdventOfCode.day5_1("ugknbfddgicrmopn\naaa\njchzalrnumimnmhp\nhaegwjzuvuyypxyu\ndvszwmarrgswjxmb\n")
    2
  """
  def day5_1(input), do: AdventOfCode.NiceString.count_nice(input)

  @doc ~S"""
    iex> AdventOfCode.day5_2("qjhvhtzxzqqjkmpb\nxxyxx\nuurcxstgmygtbstg\nieodomkazucvgmuy\n")
    2
  """
  def day5_2(input), do: AdventOfCode.NicerString.count_nice(input)
end

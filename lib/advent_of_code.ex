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

  @doc ~S"""
    iex> AdventOfCode.day6_1("turn on 10,10 through 20,20\nturn off 15,15 through 25,25\ntoggle 5,5 through 11,11\n")
    (7 * 7) - (2 * 2) + # top left square
    (11 * 11) - (6 * 6) - (2 * 2) # bottom right square

....................
....................
....................
....................
....OOOOOOO.........
....OOOOOOO.........
....OOOOOOO.........
....OOOOOOO.........
....OOOOOOO.........
....OOOOO..OOOOOOOOO
....OOOOO..OOOOOOOOO
.........OOOOOOOOOOO
.........OOOOOOOOOOO
.........OOOOOOOOOOO
.........OOOOO......
.........OOOOO......
.........OOOOO......
.........OOOOO......
.........OOOOO......
.........OOOOO......
  """
  def day6_1(input), do: AdventOfCode.LightGrid.run(input)

  @doc ~S"""
    iex> AdventOfCode.day6_2("turn on 10,10 through 20,20\nturn off 15,15 through 25,25\ntoggle 5,5 through 11,11\n")
    (((7 * 7) - (2 * 2)) * 2) + # top left square
    ((2 * 2) * 3)             + # intersection
    ((11 * 11) - (6 * 6) - (2 * 2)) # bottom right square

....................
....................
....................
....................
....2222222.........
....2222222.........
....2222222.........
....2222222.........
....2222222.........
....2222233111111111
....2222233111111111
.........11111111111
.........11111111111
.........11111111111
.........11111000000
.........11111000000
.........11111000000
.........11111000000
.........11111000000
.........11111000000
  """
  def day6_2(input), do: AdventOfCode.BrightnessGrid.run(input)

  @doc ~S"""
    iex> AdventOfCode.day7_1("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i\n")
    %{d: 72, e: 507, f: 492, g: 114, h: 65412, i: 65079, x: 123, y: 456}
  """
  def day7_1(input), do: AdventOfCode.Circuit.run(input)

  def day7_2(input, new_b_value) do
    # TODO would be nicer to make circuit reconfigure when input comes in rather than just hacking input
    Regex.replace(~r/\d+ -> b\n/, input, "#{new_b_value} -> b\n")
    |> AdventOfCode.Circuit.run
  end

  @doc ~S"""
    iex> AdventOfCode.day8_1("\"\"\n\"abc\"\n\"aaa\\\"aaa\"\n\"\\x27\"")
    (2 + 5 + 10 + 6) - (0 + 3 + 7 + 1)
  """
  def day8_1(input) do
    AdventOfCode.StringCodeSize.run(input)
    |> AdventOfCode.StringCodeSize.code_memory_diff
  end

  @doc ~S"""
    iex> AdventOfCode.day8_2("\"\"\n\"abc\"\n\"aaa\\\"aaa\"\n\"\\x27\"")
    (6 + 9 + 16 + 11) - (2 + 5 + 10 + 6)
  """
  def day8_2(input) do
    AdventOfCode.StringCodeSize.run(input)
    |> AdventOfCode.StringCodeSize.encoded_code_diff
  end

  @doc ~S"""
    iex> AdventOfCode.day9_1("London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141")
    464 + 141 # London -> Dublin -> Belfast
  """
  def day9_1(input) do
    AdventOfCode.TravellingSanta.run_optimal(input)
  end

  @doc ~S"""
    iex> AdventOfCode.day9_2("London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141")
    464 + 518 # Dublin -> London -> Belfast
  """
  def day9_2(input) do
    AdventOfCode.TravellingSanta.run_deoptimal(input)
  end

  @doc ~S"""
    iex> AdventOfCode.day10_1(1)
    11

    iex> AdventOfCode.day10_1(11)
    21

    iex> AdventOfCode.day10_1(21)
    1211

    iex> AdventOfCode.day10_1(1211)
    111221

    iex> AdventOfCode.day10_1(111221)
    312211

    iex> AdventOfCode.day10_1(1, 5) # 5 iterations
    312211
  """
  def day10_1(number, iterations \\ 1) do
    AdventOfCode.LookSee.run(number, iterations)
  end
end

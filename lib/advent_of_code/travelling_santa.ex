defmodule AdventOfCode.TravellingSanta do
  def run_optimal(input), do: run(input, &Enum.min/1)
  def run_deoptimal(input), do: run(input, &Enum.max/1)

  defp run(input, optimizer_fn) do
    input
    |> AdventOfCode.InputString.run(
        %{towns: MapSet.new, distances: %{}},
        &parse_travel_distance/1,
        &build_routes/2
       )
    |> optimal_path(optimizer_fn)
  end

  defp parse_travel_distance(line) do
    [_all, town1, town2, distance] = Regex.run(~r/(.+) to (.*) = (\d+)/,line)
      town1 = String.to_atom(town1)
      town2 = String.to_atom(town2)
      distance = String.to_integer(distance)
      {town1, town2, distance}
  end

  defp build_routes(
    {town1, town2, distance},
    %{towns: towns, distances: distances}
  ) do
    %{
      towns: towns |> MapSet.put(town1) |> MapSet.put(town2),
      distances: distances |> Map.put(town_pair(town1, town2), distance)
    }
  end

  defp town_pair(town1, town2) when town1 < town2, do: {town1, town2}
  defp town_pair(town1, town2) when town1 > town2, do: {town2, town1}

  defp optimal_path(%{towns: towns, distances: distances}, optimizer_fn) do
    towns
    |> MapSet.to_list
    |> permutations
    |> Stream.map(&(route_lengths(&1, distances)))
    |> optimizer_fn.()
  end

  defp route_lengths(route, distances) do
    route
    |> Stream.chunk(2, 1)
    |> Stream.map(fn([town1, town2]) -> town_pair(town1, town2) end)
    |> Stream.map(fn(pair) -> distances[pair] end)
    |> Enum.sum
  end

  def permutations([]), do: [[]]
  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h|t]
  end
end

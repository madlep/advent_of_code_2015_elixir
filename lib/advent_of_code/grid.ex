defmodule AdventOfCode.Grid do
  def count_visited_locations(input, visitor_count \\ 1), do: visit(input, build_visitors(visitor_count), build_visited)

  defp build_visitors(count) do
    (1..count)
    |> Enum.map(&({"visitor #{&1}", 0, 0}))
    |> Enum.reduce(:queue.new, &(:queue.in(&1, &2)))
  end

  defp build_visited do
    HashSet.new |> Set.put({0,0})
  end

  defp visit("", _visitors, visited), do: Set.size(visited)
  defp visit(<<"<", rest ::binary>>, visitors, visited), do: update(rest, {-1, 0 }, visitors, visited)
  defp visit(<<">", rest ::binary>>, visitors, visited), do: update(rest, {1 , 0 }, visitors, visited)
  defp visit(<<"^", rest ::binary>>, visitors, visited), do: update(rest, {0 , -1}, visitors, visited)
  defp visit(<<"v", rest ::binary>>, visitors, visited), do: update(rest, {0 , 1 }, visitors, visited)

  defp update(input, movement, visitors, visited) do
    { {:value, visitor}, visitors} = :queue.out(visitors)
    visitor = move(visitor, movement)
    {_name, x, y} = visitor
    visit(input, :queue.in(visitor, visitors), Set.put(visited, {x,y}))
  end

  defp move(_visitor = {name, x,y}, _movement = {dx, dy}), do: {name, x + dx, y + dy}
end

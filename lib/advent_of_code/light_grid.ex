defmodule AdventOfCode.LightGrid do
  import String, only: [to_integer: 1]

  def run(input) do
    input
    |> AdventOfCode.InputString.run(init(), &parse/1, &execute_instruction/2)
    |> count_on
  end

  defp parse(line) do
    [instruction, x1, y1, x2, y2] = Regex.run(
      ~r/(.*) (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/,
      line, capture: :all_but_first)
    { instruction,
      {to_integer(x1), to_integer(y1)},
      {to_integer(x2), to_integer(y2)}
    }
  end

  defp init() do
    :ets.new(:light_grid, [:public,{:write_concurrency, :true}, {:read_concurrency, true}])
  end

  defp execute_instruction({instruction, {x1,y1}, {x2, y2}}, tid) do
    (x1..x2)
    |> Enum.map(fn(x) ->
      Task.async(fn () ->
        (y1..y2) |> Enum.each(fn(y) ->
          update_light(instruction, x, y, tid)
        end)
      end)
    end)
    |> Enum.map(&Task.await/1)
    tid
  end

  defp update_light("turn on", x, y, tid) do
    :ets.insert(tid, {{x,y}, true})
  end

  defp update_light("turn off", x, y, tid) do
    :ets.delete(tid, {x,y})
  end

  defp update_light("toggle", x, y, tid) do
    case :ets.lookup(tid, {x, y}) do
      [] -> update_light("turn on", x,y, tid)
      [_exists] -> update_light("turn off", x,y, tid)
    end
  end

  defp count_on(tid) do
    :ets.info(tid, :size)
  end
end

defmodule AdventOfCode.BrightnessGrid do
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
    :ets.new(:light_grid, [])
  end

  defp execute_instruction({instruction, {x1,y1}, {x2, y2}}, tid) do
    (x1..x2)
    |> Enum.map(fn(x) ->
      (y1..y2) |> Enum.each(fn(y) ->
        update_light(instruction, x, y, tid)
      end)
    end)
    tid
  end

  defp update_light("turn on", x, y, tid) do
    :ets.update_counter(tid, _key={x,y}, {_pos=2, _incr=1}, _default={{x, y}, 0})
  end

  defp update_light("turn off", x, y, tid) do
    :ets.update_counter(tid, _key={x,y}, {_pos=2, _incr=-1, _threshold=0, _setvalue=0}, _default={{x, y}, 0})
  end

  defp update_light("toggle", x, y, tid) do
    :ets.update_counter(tid, _key={x,y}, {_pos=2, _incr=2}, _default={{x, y}, 0})
  end

  def count_on(tid) do
    :ets.foldl(fn({{_x, _y}, brightness}, acc) -> acc + brightness end, 0, tid)
  end
end

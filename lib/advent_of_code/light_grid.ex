defmodule AdventOfCode.LightGrid do
  import AdventOfCode.InputString, only: [to_io_stream: 1]
  import String, only: [to_integer: 1]

  def run(input) do
    tid = init()
    input
    |> parse_input
    |> Enum.each(&(execute_instruction(&1, tid)))
    count_on(tid)
  end

  def parse_input(input) do
    input
    |> to_io_stream
    |> Stream.map(&parse/1)
  end

  defp parse(line) do
    Regex.run(~r/(.*) (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/, line, capture: :all_but_first)
    |> generate_instruction
  end

  defp generate_instruction(instruction, x1, y1, x2, y2) do
    {instruction, {to_integer(x1), to_integer(y1)}, {to_integer(x2), to_integer(y2)} }
  end

  defp generate_instruction(["turn on", x1, y1, x2, y2]), do: generate_instruction(:turn_on, x1, y1, x2, y2)
  defp generate_instruction(["turn off", x1, y1, x2, y2]), do: generate_instruction(:turn_off, x1, y1, x2, y2)
  defp generate_instruction(["toggle", x1, y1, x2, y2]), do: generate_instruction(:toggle, x1, y1, x2, y2)

  def init() do
    :ets.new(:light_grid, [:public,{:write_concurrency, :true}, {:read_concurrency, true}])
  end

  def execute_instruction({instruction, {x1,y1}, {x2, y2}}, tid) do
    (x1..x2)
    |> Enum.map(fn(x) ->
      Task.async(fn () ->
        (y1..y2) |> Enum.each(fn(y) ->
          :erlang.apply(__MODULE__, instruction, [x, y, tid])
        end)
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

  def turn_on(x, y, tid) do
    :ets.insert(tid, {{x,y}, true})
  end

  def turn_off(x, y, tid) do
    :ets.delete(tid, {x,y})
  end

  def toggle(x, y, tid) do
    case :ets.lookup(tid, {x, y}) do
      [] -> turn_on(x,y, tid)
      [_exists] -> turn_off(x,y, tid)
    end
  end

  def count_on(tid) do
    :ets.info(tid, :size)
  end
end

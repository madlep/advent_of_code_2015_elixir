defmodule AdventOfCode.Wrapping do
  def calculate_wrapping_area(input_stream) do
    input_stream
    |> Enum.reduce(0, &(parse(&1) |> calculate_area |> + &2))
  end

  defp parse(present) do
    [_original, l, w, h] = Regex.run(~r/(\d+)x(\d+)x(\d+)/, present)
    [l ,w, h] = [l, w, h] |> Enum.map(&String.to_integer/1)
    {l, w, h}
  end

  defp calculate_area({l, w, h}) do
    sides = [l * w, w * h, h * l]
    spare = Enum.min(sides)
    Enum.reduce(sides, &+/2) * 2 + spare
  end

  def calculate_ribbon_length(input_stream) do
    input_stream
    |> Enum.reduce(0, &(parse(&1) |> calculate_length |> + &2))
  end

  defp calculate_length({l, w, h}) do
    [small_side1, small_side2] = [l, w, h] |> Enum.sort |> Enum.take(2)
    smallest_perimeter = small_side1 * 2 + small_side2 * 2
    volume = l * w * h
    smallest_perimeter + volume
  end
end

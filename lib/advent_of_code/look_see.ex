# this is fine for small numbers, but it gets HUGE with 40 iterations. Scrapping this and going with bitstring approach I'd considered originally
defmodule AdventOfCode.LookSee do
  @digit_multipler 10

  def run(number, iterations) do
    number
    |> Stream.unfold( fn n ->
      result = look_see(n)
      {n, result}
    end)
    |> Stream.drop(iterations - 1)
    |> Enum.at(1)
  end

  def look_see(number) do
    number
    |> div(@digit_multipler)
    |> look_see(
      %{digit: rem(number, @digit_multipler), repeats: 1},
      %{result: 0, multiplier: 1}
    )
  end

  # finished - number is 0 meaning we've 'popped' all digits off the tail
  defp look_see(
    0,
    %{digit: dig, repeats: rep},
    %{result: res, multiplier: mult}
  ) do
    write_result(res, dig, rep, mult)
    #res + (rep * mult * @digit_multipler) + (dig * mult)
  end

  # repeated digit - bump the repeat count and don't write it to result
  defp look_see(
    number,
    %{digit: dig, repeats: rep},
    %{result: res, multiplier: mult}
  ) when rem(number, @digit_multipler) == dig do
    look_see(
      div(number, @digit_multipler),
      %{digit: dig, repeats: rep + 1},
      %{result: res, multiplier: mult}
    )
  end

  # changed digit - reset repeats and write to result
  defp look_see(
    number,
    %{digit: dig, repeats: rep},
    %{result: res, multiplier: mult}
  ) do
    look_see(
      div(number, @digit_multipler),
      %{digit: rem(number, @digit_multipler), repeats: 1},
      %{result: res + (rep * mult * @digit_multipler) + (dig * mult), multiplier: mult * 100})
  end

  defp write_result(result, digit, repeats, multiplier) do
    result + (repeats * multiplier * @digit_multipler) + (digit * multiplier)
  end
end

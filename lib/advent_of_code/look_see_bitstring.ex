defmodule AdventOfCode.LookSeeBitstring do

  def run(number, iterations) do
    number
    |> Stream.unfold( fn n ->
      result = look_see(n)
      {n, result}
    end)
    |> Enum.at(iterations)
  end

  def look_see(number) do
    <<digit::utf8, rest::binary>> = number
   look_see(rest, %{digit: digit, repeats: 1}, "")
  end

  # termination case - we're done
  defp look_see(<<"">>, %{digit: digit, repeats: rep}, result) do
    write_result(result, rep, digit)
  end

  # repeating digit - increase repeats, and don't write to result
  defp look_see(
    <<digit::utf8, rest::binary>>,
    %{digit: digit, repeats: rep}, result
  ) do
    look_see(rest, %{digit: digit, repeats: rep + 1}, result)
  end

  defp look_see(
    <<new_digit::utf8, rest::binary>>,
    %{digit: digit, repeats: rep}, result
  ) do
    look_see(
      rest,
      %{digit: new_digit, repeats: 1},
      write_result(result, rep, digit)
    )
  end

  defp write_result(result, repeats, digit) do
    repeats_str = Integer.to_string(repeats)
    <<result::binary, repeats_str::binary, digit::utf8>>
  end
end

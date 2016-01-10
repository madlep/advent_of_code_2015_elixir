defmodule AdventOfCode.JsonAccounting do
  def add_numbers(json), do: add_numbers(json, "", 0)

  defp add_numbers("", "", sum), do: sum

  # number character encountered "-" or "0" - "9"
  defp add_numbers(<<num_char::utf8, rest::binary>>, current, sum)
  when num_char == ?- or (num_char >= ?0 and num_char <= ?9) do
    add_numbers(rest, <<current::binary, num_char::utf8>>, sum)
  end

  # just a regular character - and not immediately after a number,
  # so no accumulation needed
  defp add_numbers(<<_char::utf8, rest::binary>>, "", sum) do
    add_numbers(rest, "", sum)
  end

  # we just changed from a number to non number. accumulate number onto sum
  defp add_numbers(<<_char::utf8, rest::binary>>, number_str, sum) do
    add_numbers(rest, "", sum + String.to_integer(number_str))
  end

end

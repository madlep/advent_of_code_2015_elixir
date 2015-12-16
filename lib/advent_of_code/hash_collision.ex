defmodule AdventOfCode.HashCollision do
  def find_collision(prefix, leading_zero_count), do: find_collision(prefix, leading_zero_count * 4, 1)
  defp find_collision(prefix, zero_bits, n) do
    case :erlang.md5("#{prefix}#{n}") do
      <<0::size(zero_bits), _::bits>> -> n
      _any -> find_collision(prefix, zero_bits, n + 1)
    end
  end
end

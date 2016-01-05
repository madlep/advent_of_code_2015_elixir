defmodule AdventOfCode.Password do
  def next_valid(password) do
    password
    |> Stream.unfold(fn password ->
      new_password  = increment_password(password)
      {new_password, new_password}
    end)
    |> Stream.filter(&valid?/1)
    |> Enum.at(0)
  end

  def increment_password(password) do
    password
    |> Enum.reverse
    |> increment_password([])
    |> Enum.reverse
  end

  def increment_password([letter|rest], carry) do
    case increment_letter(letter) do
      {:ok, new_letter} -> carry ++ [new_letter | rest]
      {:carry, ?a} -> increment_password(rest, [?a | carry])
    end
  end

  def increment_letter(?z), do: {:carry, ?a}
  def increment_letter(char) when char >= ?a and char < ?z, do: {:ok, char + 1}

  def valid?(password) do
    straight_3?(password) &&
    legal_letters?(password, 'iol') &&
    has_pairs?(password, 2)
  end

  def straight_3?([]), do: false
  def straight_3?([letter|rest]) do
    # can't do these in match pattern
    letter1 = letter + 1
    letter2 = letter + 2
    case rest do
      [^letter1 | [^letter2 | _rest]] -> true
      _any -> straight_3?(rest)
    end
  end

  def legal_letters?(password, illegal_letters) do
    password
    |> Enum.any?(&(Enum.member?(illegal_letters, &1)))
    |> Kernel.not
  end

  def has_pairs?(password, expected_pair_count) do
    has_pairs?(password, 0, expected_pair_count)
  end

  # enough pairs found - we're good
  defp has_pairs?(_password, expected_pair_count, expected_pair_count), do: true

  # finished password scanning - nothing found
  defp has_pairs?([], _pair_count, _expected_pair_count), do: false

  # pair found
  defp has_pairs?([letter | [letter | rest]], pair_count, expected_pair_count) do
    has_pairs?(rest, pair_count + 1, expected_pair_count)
  end

  # no pair found
  defp has_pairs?([_letter|rest], pair_count, expected_pair_count) do
    has_pairs?(rest, pair_count, expected_pair_count)
  end
end

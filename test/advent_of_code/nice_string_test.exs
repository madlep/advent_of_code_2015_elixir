defmodule AdventOfCode.NiceStringTest do
  use ExUnit.Case, async: true

  alias AdventOfCode.NiceString, as: N

  test ".nice? is not nice if it has less than 3 vowels" do
    refute N.nice?("aacc")
    refute N.nice?("acc")
    refute N.nice?("cc")
  end

  test ".nice? is not nice if it doesn't contain a letter twice in a row" do
    refute N.nice?("aceio")
    refute N.nice?("acaeio")
  end

  test ".nice? is not nice if it contains 'ab'" do
    refute N.nice?("abeii")
  end

  test ".nice? is not nice if it contains 'cd'" do
    refute N.nice?("cdeii")
  end

  test ".nice? is not nice if it contains 'pq'" do
    refute N.nice?("pqeii")
  end

  test ".nice? is not nice if it contains 'xy'" do
    refute N.nice?("xyeii")
  end

  test ".nice? is nice if it contains 3 vowels, one letter twice in a row, and doesn't contain 'ab', 'cd', 'pq', 'xy'" do
    assert N.nice?("aippe")
  end
end

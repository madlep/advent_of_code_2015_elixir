defmodule AdventOfCode.NicerStringTest do
  use ExUnit.Case, async: true

  alias AdventOfCode.NicerString, as: N

  test ".nicer? is not nice if it doesn't have a pair of letters that appear twice without overlapping" do
    assert N.nicer?("xyxy")
    refute N.nicer?("xyx")
    refute N.nicer?("xiyxy")
    assert N.nicer?("xyaiaxy")
    assert N.nicer?("aabaa")
    assert N.nicer?("aaaa")
    refute N.nicer?("aaa")
    refute N.nicer?("aa")
  end

  test ".nicer? is not nice if it doesn't contain one letter repeated, with exactly one letter in between" do
    assert N.nicer?("xyxaxy")
    refute N.nicer?("xy")
    refute N.nicer?("xyaxy")
  end
end

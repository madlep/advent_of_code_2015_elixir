defmodule AdventOfCode.HashCollisionTest do
  use ExUnit.Case, async: true

  alias AdventOfCode.HashCollision, as: H

  test "find_collision works to 5 leading hex zeroes (20 bits)" do
    assert H.find_collision("abcdef", 5) == 609043
    assert H.find_collision("pqrstuv", 5) == 1048970
  end

end

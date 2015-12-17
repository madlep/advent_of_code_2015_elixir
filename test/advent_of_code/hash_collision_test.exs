defmodule AdventOfCode.HashCollisionTest do
  use ExUnit.Case, async: true

  alias AdventOfCode.HashCollision, as: H

  test "find_collision works to specified leading hex zeroes" do
    # these are SLOW. run with reduced count so mix test isn't annoying
    # assert H.find_collision("abcdef", 5) == 609043
    # assert H.find_collision("pqrstuv", 5) == 1048970
    assert H.find_collision("abcdef", 3) == 3337
    assert H.find_collision("pqrstuv", 4) == 6982
  end

end

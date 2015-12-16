defmodule AdventOfCode.HashCollisionParallel do
  # Proof of concept concurrent collision search
  # on early 2013 i7 3ghz dual core macbook pro, this actually runs slower though
  # I guess CPU heavy tasks arean't best demo of concurrency on limited hardware
  # probably a more optimal way to do this than splitting by mod

  def find_collision_p(prefix, leading_zero_count, concurrency) do
    pids = (1..concurrency) |> Enum.map( fn (n) ->
      caller = self
      spawn_link(fn() -> find_collision_p(caller, prefix, leading_zero_count * 4, n, concurrency) end)
    end)
    receive do
      {:solution, solution} ->
        # TODO need to actually check that we have the SMALLEST collision
        # it's possible another process could have race condition where it finds smaller
        # collision, but doesn't report it first
        # need to send smallest known collision to pids when telling them to stop,
        # and let them report values they find that are smaller, then keep running up to that point
        pids |> Enum.each(&(send(&1, :stop)))
        solution
    end
  end

  defp find_collision_p(caller, prefix, zero_bits, n, step_size) do
    case :erlang.md5("#{prefix}#{n}") do
      <<0::size(zero_bits), _::bits>> -> send(caller, {:solution, n})
      _any ->
        receive do
          :stop -> :ok
        after 0 ->
          find_collision_p(caller, prefix, zero_bits, n + step_size, step_size)
        end
    end
  end
end

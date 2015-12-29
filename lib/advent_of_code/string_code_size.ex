defmodule AdventOfCode.StringCodeSize do

  defmodule State do
    defstruct [code: 0, memory: 0, encoded: 0]
  end

  def run(input) do
    input
    |> AdventOfCode.InputString.run(%State{}, &sizes/1, &sum_sizes/2)
  end

  def sizes(line) do
    line
    |> String.strip
    |> sizes(%State{})
  end

  def sizes(<<"">>, state=%State{}), do: state

  def sizes(<<"\"", rest::binary>>, state=%State{}) do
    state = state
    |> incr_code
    |> incr_encoded(3)
    sizes(rest, state)
  end

  def sizes(<<"\\\"", rest::binary>>, state=%State{}) do
    state = state
    |> incr_memory
    |> incr_code(2)
    |> incr_encoded(4)
    sizes(rest, state)
  end

  def sizes(<<"\\\\", rest::binary>>, state=%State{}) do
    state = state
    |> incr_memory
    |> incr_code(2)
    |> incr_encoded(4)
    sizes(rest, state)
  end

  def sizes(<<"\\x", _hex1::utf8, _hex2::utf8, rest::binary>>, state=%State{}) do
    state = state
    |> incr_memory
    |> incr_code(4)
    |> incr_encoded(5)
    sizes(rest, state)
  end

  def sizes(<<_char::utf8, rest::binary>>, state=%State{}) do
    sizes(rest, incr_all(state))
  end


  defp incr_code(state=%State{code: csize}, incr \\ 1) do
    %State{state | code: csize + incr}
  end

  defp incr_memory(state=%State{memory: msize}, incr \\ 1) do
    %State{state | memory: msize + incr}
  end

  defp incr_encoded(state=%State{encoded: esize}, incr \\ 1) do
    %State{state | encoded: esize + incr}
  end

  defp incr_all(%State{code: csize, memory: msize, encoded: esize}, incr \\ 1) do
    %State{code: csize + 1, memory: msize + incr, encoded: esize + incr}
  end

  defp sum_sizes(
    %State{code: csize1, memory: msize1, encoded: esize1},
    %State{code: csize2, memory: msize2, encoded: esize2}
  ) do
    %State{
      code: csize1 + csize2,
      memory: msize1 + msize2,
      encoded: esize1 + esize2
    }
  end

  def code_memory_diff(%State{code: csize, memory: msize}) do
    csize - msize
  end

  def encoded_code_diff(%State{code: csize, encoded: esize}) do
    esize - csize
  end
end

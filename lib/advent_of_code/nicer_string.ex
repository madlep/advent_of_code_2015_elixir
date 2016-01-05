defmodule AdventOfCode.NicerString do
  # not loving this solution.
  # it got messy and hacky
  # needs cleaning up and refactoring if I get around to it

  import AdventOfCode.InputString, only: [to_io_stream: 1]

  defstruct counts: %{}, duplicate_found: false, bracket_found: false

  alias AdventOfCode.NicerString, as: T

  def count_nice(input) do
    input
    |> to_io_stream
    |> Enum.count(&nicer?/1)
  end

  def nicer?(string) do
    string
    |> String.to_char_list
    |> chunk3_with_index
    # TODO use reduce_while and bail out early if badness found to avoid scanning whole straing
    |> Enum.reduce(%T{}, &chunk_nicer?/2)
    |> result_nicer?
  end

  defp chunk_nicer?(chunk, state) do
    state
    |> count_combo(chunk)
    |> detect_bracket(chunk)
  end

  defp count_combo(state=%T{counts: counts}, {[letter1,letter2,_], i}) do
    combo = [letter1, letter2]
    case counts[combo] do
      nil                 -> %T{state| counts: Map.put(counts, combo, {1, i})}
      {old_count,old_i}  -> if i - old_i >= 2 do
        %T{state|
          counts: Map.put(counts, combo, {old_count + 1, i}),
          duplicate_found: true}
      else
        state
      end
    end
  end

  defp detect_bracket(state, {[letter,_,letter], _i}) do
    %T{state|bracket_found: true}
  end
  defp detect_bracket(state, _chunk), do: state

  defp result_nicer?(%T{duplicate_found: dup, bracket_found: bracket}) do
    dup && bracket
  end

  # couldn't get built in Stream.chunk/4 to play nice
  # specifically, wouldn't generate chunk for last char
  # so roll my own
  defp chunk3_with_index(str), do: chunk3_with_index(str, [], 0)
  defp chunk3_with_index([], chunks, _i), do: :lists.reverse(chunks)
  defp chunk3_with_index([c2], chunks, i), do: chunk3_with_index([], [{[c2, ?_, ?_], i} | chunks], i + 1)
  defp chunk3_with_index([c1,c2], chunks, i), do: chunk3_with_index([c2], [{[c1,c2,?_], i} | chunks], i + 1)
  defp chunk3_with_index([c1, c2, c3|rest], chunks, i), do: chunk3_with_index([c2, c3 | rest], [{[c1, c2, c3], i} | chunks], i + 1)
end

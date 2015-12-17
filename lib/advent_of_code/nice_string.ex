defmodule AdventOfCode.NiceString do
  import AdventOfCode.InputString, only: [to_io_stream: 1]

  defstruct vowels: 0, repeated: false, not_bad: true

  alias AdventOfCode.NiceString, as: T

  def count_nice(input) do
    input
    |> to_io_stream
    |> Enum.count(&nice?/1)
  end

  def nice?(string) do
    string
    |> String.to_char_list
    |> Stream.chunk(2, 1, '_')
    # TODO use reduce_while and bail out early if badness found to avoid scanning whole straing
    |> Enum.reduce(%T{}, &chunk_nice?/2) 
    |> result_nice?
  end

  defp chunk_nice?(chunk, state) do
    state
    |> count_vowel(chunk)
    |> detect_repeated(chunk)
    |> detect_bad(chunk)
  end

  defp count_vowel(state, [?a,_]), do: inc_vowels(state)
  defp count_vowel(state, [?e,_]), do: inc_vowels(state)
  defp count_vowel(state, [?i,_]), do: inc_vowels(state)
  defp count_vowel(state, [?o,_]), do: inc_vowels(state)
  defp count_vowel(state, [?u,_]), do: inc_vowels(state)
  defp count_vowel(state, _not_vowel), do: state
  defp inc_vowels(state=%T{vowels: v}), do: %T{state | vowels: v+ 1}

  defp detect_repeated(state=%T{}, [char, char]), do: %T{state | repeated: true}
  defp detect_repeated(state=%T{}, [_char1, _char2]), do: state

  defp detect_bad(state, 'ab'), do: mark_bad(state)
  defp detect_bad(state, 'cd'), do: mark_bad(state)
  defp detect_bad(state, 'pq'), do: mark_bad(state)
  defp detect_bad(state, 'xy'), do: mark_bad(state)
  defp detect_bad(state, _ok), do: state
  defp mark_bad(state), do: %T{state | not_bad: false }

  defp result_nice?(%T{vowels: vowels, repeated: repeated, not_bad: not_bad}) do
    vowels >= 3 &&
    repeated &&
    not_bad
  end

end

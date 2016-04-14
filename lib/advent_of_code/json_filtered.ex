defmodule AdventOfCode.JsonFiltered do
  @filter_attribute "red"
  def add_numbers(json) do
    json
    |> lex
  end

  def lex(json) do
    json
    |> Stream.unfold(fn(json) -> do_lex(json) end)
  end

  def parse(lexer) do
    lexer
    |> Enum.reduce(%{stack: [], sum: 0}, &parse_token/2)
  end

  defp parse_token(:leftcurly, acc=%{stack: stack}) do
    %{acc|stack: [:object|stack]}
  end

  defp parse_token(:rightcurly, acc=%{stack: [:object|rest]}) do
    %{acc|stack: rest}
  end

  defp parse_token(:leftsquare, acc=%{stack: stack}) do
    %{acc|stack: [:array|stack]}
  end

  defp parse_token(:rightsquare, acc=%{stack: [:array|rest]}) do
    %{acc|stack: rest}
  end

  defp do_lex(<<"">>), do: nil
  defp do_lex(<<?{, rest::binary>>), do: {:leftcurly, rest}
  defp do_lex(<<?}, rest::binary>>), do: {:rightcurly, rest}
  defp do_lex(<<?[, rest::binary>>), do: {:leftsquare, rest}
  defp do_lex(<<?], rest::binary>>), do: {:rightsquare, rest}
  defp do_lex(<<?:, rest::binary>>), do: {:colon, rest}
  defp do_lex(<<?,, rest::binary>>), do: {:comma, rest}
  defp do_lex(<<?", rest::binary>>), do: lex_string(rest, "")
  defp do_lex(json=<<num::utf8, _rest::binary>>)
  when (num >= ?0 and num <= ?9) or (num == ?-) do
    lex_integer(json, "")
  end

  defp lex_string(<<?", rest::binary>>, acc), do: {{:string, acc}, rest}
  defp lex_string(<<char::utf8, rest::binary>>, acc) do
    lex_string(rest, <<acc::binary, char::utf8>>)
  end

  def lex_integer(<<num::utf8, rest::binary>>, acc)
  when (num >= ?0 and num <= ?9) or (num == ?-) do
    lex_integer(rest, <<acc::binary, num::utf8>>)
  end
  def lex_integer(json, acc), do: {{:integer, String.to_integer(acc)}, json}
end

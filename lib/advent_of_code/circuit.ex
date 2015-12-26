defmodule AdventOfCode.Circuit do
  use Bitwise

  alias AdventOfCode.Wire

  def run(input) do
    input
    |> AdventOfCode.InputString.run(%{}, &parse/1, &execute_instruction/2)
    |> extract_results
  end

  defp parse(input_line) do
    input_line
    |> String.split
    |> parse_tokens
  end

  defp parse_tokens([input1, "->", output]) do
    {:value, value_or_wire(input1), wire(output)}
  end

  defp parse_tokens([input1, binary_op, input2, "->", output]) do
    {atom(binary_op), value_or_wire(input1), value_or_wire(input2), wire(output)}
  end

  defp parse_tokens([unary_op, input, "->", output]) do
    {atom(unary_op), value_or_wire(input), wire(output)}
  end

  defp value_or_wire(input) do
    if Regex.match?(~r/\d+/, input) do
      value(input)
    else
      wire(input)
    end
  end

  defp value(input), do: String.to_integer(input)

  defp wire(input), do: String.to_atom(input)

  defp atom(input) do
    input
    |> String.downcase
    |> String.to_atom
  end

  defp execute_instruction({op, input1, input2, output}, state) do
    {output_wire, state} = get_wire(output, state)
    {input1_wire, state} = get_wire(input1, state)
    {input2_wire, state} = get_wire(input2, state)

    spawn_link(fn ->
      Wire.assign(output_wire, do_op(op, Wire.value(input1_wire), Wire.value(input2_wire)))
    end)
    state
  end

  defp execute_instruction({op, input, output}, state) do
    {output_wire, state} = get_wire(output, state)
    {input_wire, state} = get_wire(input, state)

    spawn_link(fn ->
      Wire.assign(output_wire, do_op(op, Wire.value(input_wire)))
    end)
    state
  end

  defp get_wire(wire_value, state) when is_integer(wire_value) do
    wire = Wire.new()
    Wire.assign(wire, wire_value)
    {wire, state}
  end

  defp get_wire(wire_label, state) when is_atom(wire_label) do
    state
    |> Dict.get_and_update(wire_label,
      fn (nil) ->
        wire = Wire.new()
        {wire, wire}
      (wire) ->
        {wire, wire}
      end)
  end

  defp do_op(:value, value),           do: value
  defp do_op(:not, value) do
    result = ~~~ value
    if result < 0, do: 65536 + result, else: result
  end
  defp do_op(:and, value1, value2),    do: value1 &&& value2
  defp do_op(:or, value1, value2),     do: value1 ||| value2
  defp do_op(:lshift, value1, value2), do: value1 <<<   value2
  defp do_op(:rshift, value1, value2), do: value1 >>>   value2

  defp extract_results(state) do
    for {label,wire} <- state do
      {label, Wire.value(wire)}
    end
    |> Enum.into %{}
  end
end

defmodule AdventOfCode.Wire do
  use GenServer

  alias AdventOfCode.Wire

  defstruct [value: :unresolved, pending_callers: []]

  ## public API
  def new do
    {:ok, wire} = GenServer.start_link(__MODULE__, %Wire{value: :unresolved})
    wire
  end

  def assign(wire, value), do: GenServer.cast(wire, {:assign, value})

  def value(wire), do: GenServer.call(wire, :value)

  ## callbacks
  def handle_cast({:assign, value}, state=%Wire{pending_callers: pending_callers}) do
    for caller <- pending_callers, do: GenServer.reply(caller, value)
    {:noreply, %{state| value: value, pending_callers: []}}
  end

  def handle_call(:value, from, state=%{value: :unresolved, pending_callers: pending_callers}) do
    {:noreply, %Wire{state | pending_callers: [from | pending_callers]}}
  end

  def handle_call(:value, _from, state=%{value: value}) do
    {:reply, value, state}
  end
end

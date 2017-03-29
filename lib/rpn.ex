defmodule Rpn do
  use GenServer
  alias Rpn.TapePrinter

  ### Client API

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, [], options)
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def push(pid, op) do
    GenServer.cast(pid, {:push, op})
  end

  ### Server API

  def init() do
    {:ok, []}
  end

  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, :+}, [ second | [ first | rest ] ]) do
    val = first + second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end
  def handle_cast({:push, :-}, [ second | [ first | rest ] ]) do
    val = first - second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end
  def handle_cast({:push, :x}, [ second | [ first | rest ] ]) do
    val = first * second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end
  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end
end

defmodule Rpn do
  def start do
    {:ok, spawn(__MODULE__, :loop, [[]])}
  end

  def loop(stack) do
    receive do
      {from, ref, :peek} ->
        send(from, {ref, stack})
        loop(stack)

      {:push, :+} ->
        [ second | [ first | rest ] ] = stack
        loop([(first + second) | rest])

      {:push, :-} ->
        [ second | [ first | rest ] ] = stack
        loop([(first - second) | rest])

      {:push, :x} ->
        [ second | [ first | rest ] ] = stack
        loop([(first * second) | rest])

      {:push, val} ->
        loop([val | stack])
    end
  end

  def peek(pid) do
    ref = make_ref()
    send(pid, {self(), ref, :peek})
    receive do
      {^ref, stack} -> stack
    end
  end

  def push(pid, val) do
    send(pid, {:push, val})
  end
end

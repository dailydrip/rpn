defmodule Rpn do
  def start do
    {:ok, spawn(__MODULE__, :loop, [[]])}
  end

  def loop(stack) do
    receive do
      :not_gonna_happen ->
        :nosir_i_dont_like_it
    end
  end

  def peek(pid) do
  end

  def push(pid, val) do
  end
end

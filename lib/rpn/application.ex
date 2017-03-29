defmodule Rpn.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Rpn.TapePrinter, []),
      worker(Rpn, [[name: Rpn]])
    ]

    opts = [strategy: :one_for_one, name: Rpn.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

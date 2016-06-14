defmodule Cart do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Cart.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: Cart.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

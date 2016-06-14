# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config
config :cart, ecto_repos: [Cart.Repo]

config :cart, Cart.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cart_dev",
  username: "demo",
  password: "demo123",
  hostname: "localhost"


# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :zaspalavra,
  namespace: Zaspalavra,
  ecto_repos: [Zaspalavra.Repo]

# Configures the endpoint
config :zaspalavra, ZaspalavraWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JQyligB0ImzwJni8fEUA1BBw3/pvFF6d5QueBY7k63STgRIOCdc/NWxstZsD2J7A",
  render_errors: [view: ZaspalavraWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Zaspalavra.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

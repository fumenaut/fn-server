# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fumenaut,
  ecto_repos: [Fumenaut.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :fumenaut, Fumenaut.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HcieFkQ+NJvmHymlYwX1+thXBTx0gjGU7X9GcI8+gpf3wQt7n8rObmy4i3nIfsxT",
  render_errors: [view: Fumenaut.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fumenaut.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

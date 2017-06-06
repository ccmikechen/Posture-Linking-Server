# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :poselink,
  ecto_repos: [Poselink.Repo]

# Configures the endpoint
config :poselink, Poselink.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5CQ3u9y8nbn5Q8B1kwBwOslSZ8dirAR4Sn/eB7r5OH9Y9r9H83/v0Mvb93QtSM4N",
  render_errors: [view: Poselink.ErrorView, accepts: ~w(json)],
  pubsub: [name: Poselink.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :guardian, Guardian,
  issuer: "Poselink",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Poselink.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

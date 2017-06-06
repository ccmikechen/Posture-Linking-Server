use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :poselink, Poselink.Endpoint,
  url: [host: "test.bearlab.io", port: 4000],
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []


# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :poselink, Poselink.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "poselink_dev",
  hostname: "localhost",
  pool_size: 10

import_config "dev.secret.exs"

config :guardian, Guardian,
  secret_key: "5CQ3u9y8nbn5Q8B1kwBwOslSZ8dirAR4Sn/eB7r5OH9Y9r9H83/v0Mvb93QtSM4N"

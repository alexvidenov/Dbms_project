# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dbms_project_3,
  ecto_repos: [DbmsProject3.Repo]

# Configures the endpoint
config :dbms_project_3, DbmsProject3Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ejc5Kb2mIL5zx2rSdpkyBvZ+X7oUKYFT3HH1X+O24bvMWC0h0rDLc/vnkwJtwloL",
  render_errors: [view: DbmsProject3Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DbmsProject3.PubSub,
  live_view: [signing_salt: "cT/PltQ+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

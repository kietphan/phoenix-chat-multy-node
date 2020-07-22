# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chat_multy_node,
  ecto_repos: [ChatMultyNode.Repo]

# Configures the endpoint
config :chat_multy_node, ChatMultyNodeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Grj5ttj+hc5Evz2LdQUyHfNYJRMKre6mczwMIdpjPHM5+xZ+4JuYD+uVy+J8NuzM",
  render_errors: [view: ChatMultyNodeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ChatMultyNode.PubSub,
  live_view: [signing_salt: "U/uoX42P"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

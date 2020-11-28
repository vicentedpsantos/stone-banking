# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stone,
  ecto_repos: [Stone.Repo]

# Configures the endpoint
config :stone, StoneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fOfPtJoSoOUnskd98Pj6J0fXVWTQHvzmxEsc5JqcNJHjJuMGJ+SONZsuqwbXxDSZ",
  render_errors: [view: StoneWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Stone.PubSub,
  live_view: [signing_salt: "B8vUcyit"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Config Money
config :money,
  default_currency: :BRL,           # this allows you to do Money.new(100)
  separator: ".",                   # change the default thousands separator for Money.to_string
  delimiter: ",",                   # change the default decimal delimeter for Money.to_string
  symbol: true,                     # don’t display the currency symbol in Money.to_string
  symbol_on_right: false,           # position the symbol
  symbol_space: true,               # add a space between symbol and number
  fractional_unit: true,            # display units after the delimeter
  strip_insignificant_zeros: false

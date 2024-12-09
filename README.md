# ReqNOAA

An Elixir library to fetch weather data from the National Oceanic and Atmospheric Administration (NOAA) API.

Links:
- [NOAA API Documentation](https://www.weather.gov/documentation/services-web-api)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `req_noaa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:req_noaa, "~> 0.1.0"}
  ]
end
```

Due to the fact that the NOAA API makes use of the User-Agent header to identify the client and thus the contact and, you will need to set the following configuration values in your `config.exs` file:

```elixir
config :req_noaa,
  name: "MyApp",
  contact: "abuse@myapp.com"
```

## Reporting Issues or Getting in Touch
If you need to report an issue or have questions, please open an issue on the GitHub repository.
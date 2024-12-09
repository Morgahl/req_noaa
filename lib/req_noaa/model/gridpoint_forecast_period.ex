defmodule ReqNOAA.Model.GridpointForecastPeriod do
  @moduledoc """
  An object containing forecast information for a specific time period (generally 12-hour or 1-hour).
  """

  @derive Jason.Encoder
  defstruct [
    :number,
    :name,
    :startTime,
    :endTime,
    :isDaytime,
    :temperature,
    :temperatureUnit,
    :temperatureTrend,
    :probabilityOfPrecipitation,
    :dewpoint,
    :relativeHumidity,
    :windSpeed,
    :windGust,
    :windDirection,
    :icon,
    :shortForecast,
    :detailedForecast
  ]

  @type t :: %__MODULE__{
          :number => integer() | nil,
          :name => String.t() | nil,
          :startTime => DateTime.t() | nil,
          :endTime => DateTime.t() | nil,
          :isDaytime => boolean() | nil,
          :temperature => ReqNOAA.Model.GridpointForecastPeriodTemperature.t() | nil,
          :temperatureUnit => String.t() | nil,
          :temperatureTrend => String.t() | nil,
          :probabilityOfPrecipitation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :dewpoint => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :relativeHumidity => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :windSpeed => ReqNOAA.Model.GridpointForecastPeriodWindSpeed.t() | nil,
          :windGust => ReqNOAA.Model.GridpointForecastPeriodWindGust.t() | nil,
          :windDirection => String.t() | nil,
          :icon => String.t() | nil,
          :shortForecast => String.t() | nil,
          :detailedForecast => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:startTime, :datetime, nil)
    |> Model.deserialize(:endTime, :datetime, nil)
    |> Model.deserialize(:temperature, :struct, ReqNOAA.Model.GridpointForecastPeriodTemperature)
    |> Model.deserialize(:probabilityOfPrecipitation, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:dewpoint, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:relativeHumidity, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:windSpeed, :struct, ReqNOAA.Model.GridpointForecastPeriodWindSpeed)
    |> Model.deserialize(:windGust, :struct, ReqNOAA.Model.GridpointForecastPeriodWindGust)
  end
end

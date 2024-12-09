defmodule ReqNOAA.Model.GridpointForecast do
  @moduledoc """
  A multi-day forecast for a 2.5km grid square.
  """

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :units,
    :forecastGenerator,
    :generatedAt,
    :updateTime,
    :validTimes,
    :elevation,
    :periods
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :geometry => String.t() | nil,
          :units => ReqNOAA.Model.GridpointForecastUnits.t() | nil,
          :forecastGenerator => String.t() | nil,
          :generatedAt => DateTime.t() | nil,
          :updateTime => DateTime.t() | nil,
          :validTimes => ReqNOAA.Model.Iso8601Interval.t() | nil,
          :elevation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :periods => [ReqNOAA.Model.GridpointForecastPeriod.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:units, :struct, ReqNOAA.Model.GridpointForecastUnits)
    |> Model.deserialize(:generatedAt, :datetime, nil)
    |> Model.deserialize(:updateTime, :datetime, nil)
    |> Model.deserialize(:validTimes, :struct, ReqNOAA.Model.Iso8601Interval)
    |> Model.deserialize(:elevation, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:periods, :list, ReqNOAA.Model.GridpointForecastPeriod)
  end
end

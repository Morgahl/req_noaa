defmodule ReqNOAA.Model.Observation do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :"@id",
    :"@type",
    :elevation,
    :station,
    :timestamp,
    :rawMessage,
    :textDescription,
    :icon,
    :presentWeather,
    :temperature,
    :dewpoint,
    :windDirection,
    :windSpeed,
    :windGust,
    :barometricPressure,
    :seaLevelPressure,
    :visibility,
    :maxTemperatureLast24Hours,
    :minTemperatureLast24Hours,
    :precipitationLastHour,
    :precipitationLast3Hours,
    :precipitationLast6Hours,
    :relativeHumidity,
    :windChill,
    :heatIndex,
    :cloudLayers
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :geometry => String.t() | nil,
          :"@id" => String.t() | nil,
          :"@type" => String.t() | nil,
          :elevation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :station => String.t() | nil,
          :timestamp => DateTime.t() | nil,
          :rawMessage => String.t() | nil,
          :textDescription => String.t() | nil,
          :icon => String.t() | nil,
          :presentWeather => [ReqNOAA.Model.MetarPhenomenon.t()] | nil,
          :temperature => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :dewpoint => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :windDirection => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :windSpeed => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :windGust => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :barometricPressure => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :seaLevelPressure => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :visibility => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :maxTemperatureLast24Hours => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :minTemperatureLast24Hours => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :precipitationLastHour => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :precipitationLast3Hours => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :precipitationLast6Hours => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :relativeHumidity => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :windChill => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :heatIndex => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :cloudLayers => [ReqNOAA.Model.ObservationCloudLayersInner.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:elevation, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:timestamp, :datetime, nil)
    |> Model.deserialize(:presentWeather, :list, ReqNOAA.Model.MetarPhenomenon)
    |> Model.deserialize(:temperature, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:dewpoint, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:windDirection, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:windSpeed, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:windGust, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:barometricPressure, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:seaLevelPressure, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:visibility, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:maxTemperatureLast24Hours, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:minTemperatureLast24Hours, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:precipitationLastHour, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:precipitationLast3Hours, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:precipitationLast6Hours, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:relativeHumidity, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:windChill, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:heatIndex, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:cloudLayers, :list, ReqNOAA.Model.ObservationCloudLayersInner)
  end
end

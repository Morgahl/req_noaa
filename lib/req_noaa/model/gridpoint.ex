defmodule ReqNOAA.Model.Gridpoint do
  @moduledoc """
  Raw forecast data for a 2.5km grid square. This is a list of all potential data layers that may appear. Some layers may not be present in all areas. * temperature * dewpoint * maxTemperature * minTemperature * relativeHumidity * apparentTemperature * heatIndex * windChill * wetBulbGlobeTemperature * skyCover * windDirection * windSpeed * windGust * weather * hazards: Watch and advisory products in effect * probabilityOfPrecipitation * quantitativePrecipitation * iceAccumulation * snowfallAmount * snowLevel * ceilingHeight * visibility * transportWindSpeed * transportWindDirection * mixingHeight * hainesIndex * lightningActivityLevel * twentyFootWindSpeed * twentyFootWindDirection * waveHeight * wavePeriod * waveDirection * primarySwellHeight * primarySwellDirection * secondarySwellHeight * secondarySwellDirection * wavePeriod2 * windWaveHeight * dispersionIndex * pressure: Barometric pressure * probabilityOfTropicalStormWinds * probabilityOfHurricaneWinds * potentialOf15mphWinds * potentialOf25mphWinds * potentialOf35mphWinds * potentialOf45mphWinds * potentialOf20mphWindGusts * potentialOf30mphWindGusts * potentialOf40mphWindGusts * potentialOf50mphWindGusts * potentialOf60mphWindGusts * grasslandFireDangerIndex * probabilityOfThunder * davisStabilityIndex * atmosphericDispersionIndex * lowVisibilityOccurrenceRiskIndex * stability * redFlagThreatIndex
  """

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :"@id",
    :"@type",
    :updateTime,
    :validTimes,
    :elevation,
    :forecastOffice,
    :gridId,
    :gridX,
    :gridY,
    :weather,
    :hazards
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :geometry => String.t() | nil,
          :"@id" => String.t() | nil,
          :"@type" => String.t() | nil,
          :updateTime => DateTime.t() | nil,
          :validTimes => String.t() | nil,
          :elevation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :forecastOffice => String.t() | nil,
          :gridId => String.t() | nil,
          :gridX => integer() | nil,
          :gridY => integer() | nil,
          :weather => ReqNOAA.Model.GridpointWeather.t() | nil,
          :hazards => ReqNOAA.Model.GridpointHazards.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:updateTime, :datetime, nil)
    |> Model.deserialize(:elevation, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:weather, :struct, ReqNOAA.Model.GridpointWeather)
    |> Model.deserialize(:hazards, :struct, ReqNOAA.Model.GridpointHazards)
  end
end

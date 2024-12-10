defmodule ReqNOAA.Model.PointJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :"@id",
    :"@type",
    :cwa,
    :forecastOffice,
    :gridId,
    :gridX,
    :gridY,
    :forecast,
    :forecastHourly,
    :forecastGridData,
    :observationStations,
    :relativeLocation,
    :forecastZone,
    :county,
    :fireWeatherZone,
    :timeZone,
    :radarStation
  ]

  @type t :: %__MODULE__{
          :"@context" => any(),
          :geometry => String.t() | nil,
          :"@id" => String.t() | nil,
          :"@type" => String.t() | nil,
          :cwa => String.t() | nil,
          :forecastOffice => String.t() | nil,
          :gridId => String.t() | nil,
          :gridX => integer() | nil,
          :gridY => integer() | nil,
          :forecast => String.t() | nil,
          :forecastHourly => String.t() | nil,
          :forecastGridData => String.t() | nil,
          :observationStations => String.t() | nil,
          :relativeLocation => ReqNOAA.Model.PointRelativeLocation.t() | nil,
          :forecastZone => String.t() | nil,
          :county => String.t() | nil,
          :fireWeatherZone => String.t() | nil,
          :timeZone => String.t() | nil,
          :radarStation => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:relativeLocation, :struct, ReqNOAA.Model.PointRelativeLocation)
  end
end

defmodule ReqNOAA.Model.ObservationStationJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :"@id",
    :"@type",
    :elevation,
    :stationIdentifier,
    :name,
    :timeZone,
    :forecast,
    :county,
    :fireWeatherZone
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t(),
          :geometry => String.t() | nil,
          :"@id" => String.t() | nil,
          :"@type" => String.t() | nil,
          :elevation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :stationIdentifier => String.t() | nil,
          :name => String.t() | nil,
          :timeZone => String.t() | nil,
          :forecast => String.t() | nil,
          :county => String.t() | nil,
          :fireWeatherZone => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:elevation, :struct, ReqNOAA.Model.QuantitativeValue)
  end
end

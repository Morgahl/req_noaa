defmodule ReqNOAA.Model.ZoneGeoJson do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :id,
    :type,
    :geometry,
    :properties
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :id => String.t() | nil,
          :type => String.t(),
          :geometry => ReqNOAA.Model.GeoJsonGeometry.t() | nil,
          :properties => ReqNOAA.Model.Zone.t()
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:geometry, :struct, ReqNOAA.Model.GeoJsonGeometry)
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.Zone)
  end
end

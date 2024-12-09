defmodule ReqNOAA.Model.GeoJsonFeature do
  @moduledoc """
  A GeoJSON feature. Please refer to IETF RFC 7946 for information on the GeoJSON format.
  """

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
          :properties => map()
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:geometry, :struct, ReqNOAA.Model.GeoJsonGeometry)
  end
end

defmodule ReqNOAA.Model.GeoJsonFeatureCollection do
  @moduledoc """
  A GeoJSON feature collection. Please refer to IETF RFC 7946 for information on the GeoJSON format.
  """

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :type,
    :features
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :type => String.t(),
          :features => [ReqNOAA.Model.GeoJsonFeature.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:features, :list, ReqNOAA.Model.GeoJsonFeature)
  end
end

defmodule ReqNOAA.Model.ObservationStationCollectionGeoJson do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :type,
    :features,
    :observationStations,
    :pagination
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :type => String.t(),
          :features => [ReqNOAA.Model.ObservationStationCollectionGeoJsonAllOfFeatures.t()],
          :observationStations => [String.t()] | nil,
          :pagination => ReqNOAA.Model.PaginationInfo.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:features, :list, ReqNOAA.Model.ObservationStationCollectionGeoJsonAllOfFeatures)
    |> Model.deserialize(:pagination, :struct, ReqNOAA.Model.PaginationInfo)
  end
end

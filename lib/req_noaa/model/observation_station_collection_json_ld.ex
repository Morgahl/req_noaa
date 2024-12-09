defmodule ReqNOAA.Model.ObservationStationCollectionJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@graph",
    :observationStations,
    :pagination
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :"@graph" => [ReqNOAA.Model.ObservationStation.t()] | nil,
          :observationStations => [String.t()] | nil,
          :pagination => ReqNOAA.Model.PaginationInfo.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.ObservationStation)
    |> Model.deserialize(:pagination, :struct, ReqNOAA.Model.PaginationInfo)
  end
end

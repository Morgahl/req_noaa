defmodule ReqNOAA.Model.ObservationStationCollectionGeoJsonAllOfFeatures do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          :properties => ReqNOAA.Model.ObservationStation.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.ObservationStation)
  end
end

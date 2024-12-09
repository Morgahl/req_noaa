defmodule ReqNOAA.Model.ObservationCollectionGeoJsonAllOfFeatures do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          :properties => ReqNOAA.Model.Observation.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.Observation)
  end
end

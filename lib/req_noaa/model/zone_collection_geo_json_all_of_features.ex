defmodule ReqNOAA.Model.ZoneCollectionGeoJsonAllOfFeatures do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          :properties => ReqNOAA.Model.Zone.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.Zone)
  end
end

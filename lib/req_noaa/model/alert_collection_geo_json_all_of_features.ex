defmodule ReqNOAA.Model.AlertCollectionGeoJsonAllOfFeatures do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          :properties => ReqNOAA.Model.Alert.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.Alert)
  end
end

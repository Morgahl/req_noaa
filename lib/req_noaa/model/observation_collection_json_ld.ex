defmodule ReqNOAA.Model.ObservationCollectionJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@graph"
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :"@graph" => [ReqNOAA.Model.Observation.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.Observation)
  end
end

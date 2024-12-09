defmodule ReqNOAA.Model.TextProductTypeCollection do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@graph"
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :"@graph" => [ReqNOAA.Model.TextProductTypeCollectionGraphInner.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.TextProductTypeCollectionGraphInner)
  end
end

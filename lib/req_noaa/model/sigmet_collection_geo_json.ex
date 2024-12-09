defmodule ReqNOAA.Model.SigmetCollectionGeoJson do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :type,
    :features
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :type => String.t(),
          :features => [ReqNOAA.Model.SigmetGeoJson.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:features, :list, ReqNOAA.Model.SigmetGeoJson)
  end
end

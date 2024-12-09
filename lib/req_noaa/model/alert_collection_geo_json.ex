defmodule ReqNOAA.Model.AlertCollectionGeoJson do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :type,
    :features,
    :title,
    :updated,
    :pagination
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :type => String.t(),
          :features => [ReqNOAA.Model.AlertCollectionGeoJsonAllOfFeatures.t()],
          :title => String.t() | nil,
          :updated => DateTime.t() | nil,
          :pagination => ReqNOAA.Model.PaginationInfo.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:features, :list, ReqNOAA.Model.AlertCollectionGeoJsonAllOfFeatures)
    |> Model.deserialize(:updated, :datetime, nil)
    |> Model.deserialize(:pagination, :struct, ReqNOAA.Model.PaginationInfo)
  end
end

defmodule ReqNOAA.Model.AlertCollectionJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :title,
    :updated,
    :pagination,
    :"@context",
    :"@graph"
  ]

  @type t :: %__MODULE__{
          :title => String.t() | nil,
          :updated => DateTime.t() | nil,
          :pagination => ReqNOAA.Model.PaginationInfo.t() | nil,
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :"@graph" => [ReqNOAA.Model.Alert.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:updated, :datetime, nil)
    |> Model.deserialize(:pagination, :struct, ReqNOAA.Model.PaginationInfo)
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.Alert)
  end
end

defmodule ReqNOAA.Model.OfficeHeadlineCollection do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :"@graph"
  ]

  @type t :: %__MODULE__{
          :"@context" => any(),
          :"@graph" => [ReqNOAA.Model.OfficeHeadline.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.OfficeHeadline)
  end
end

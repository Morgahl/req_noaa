defmodule ReqNOAA.Model.AlertJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@graph"
  ]

  @type t :: %__MODULE__{
          :"@graph" => [ReqNOAA.Model.Alert.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:"@graph", :list, ReqNOAA.Model.Alert)
  end
end

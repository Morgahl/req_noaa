defmodule ReqNOAA.Model.GridpointHazards do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :values
  ]

  @type t :: %__MODULE__{
          :values => [ReqNOAA.Model.GridpointHazardsValuesInner.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:values, :list, ReqNOAA.Model.GridpointHazardsValuesInner)
  end
end

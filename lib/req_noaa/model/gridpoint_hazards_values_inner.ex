defmodule ReqNOAA.Model.GridpointHazardsValuesInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :validTime,
    :value
  ]

  @type t :: %__MODULE__{
          :validTime => ReqNOAA.Model.Iso8601Interval.t(),
          :value => [ReqNOAA.Model.GridpointHazardsValuesInnerValueInner.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:validTime, :struct, ReqNOAA.Model.Iso8601Interval)
    |> Model.deserialize(:value, :list, ReqNOAA.Model.GridpointHazardsValuesInnerValueInner)
  end
end

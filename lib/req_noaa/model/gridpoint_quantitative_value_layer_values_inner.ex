defmodule ReqNOAA.Model.GridpointQuantitativeValueLayerValuesInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :validTime,
    :value
  ]

  @type t :: %__MODULE__{
          :validTime => ReqNOAA.Model.Iso8601Interval.t(),
          :value => float() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:validTime, :struct, ReqNOAA.Model.Iso8601Interval)
  end
end

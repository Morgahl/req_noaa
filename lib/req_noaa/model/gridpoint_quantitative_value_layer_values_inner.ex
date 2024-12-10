defmodule ReqNOAA.Model.GridpointQuantitativeValueLayerValuesInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :validTime,
    :value
  ]

  @type t :: %__MODULE__{
          :validTime => String.t(),
          :value => float() | nil
        }

  def decode(value) do
    value
  end
end

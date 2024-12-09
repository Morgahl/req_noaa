defmodule ReqNOAA.Model.GridpointHazardsValuesInnerValueInner do
  @moduledoc """
  A value object representing an expected hazard.
  """

  @derive Jason.Encoder
  defstruct [
    :phenomenon,
    :significance,
    :event_number
  ]

  @type t :: %__MODULE__{
          :phenomenon => String.t(),
          :significance => String.t(),
          :event_number => integer() | nil
        }

  def decode(value) do
    value
  end
end

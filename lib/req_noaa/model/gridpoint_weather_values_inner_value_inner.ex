defmodule ReqNOAA.Model.GridpointWeatherValuesInnerValueInner do
  @moduledoc """
  A value object representing expected weather phenomena.
  """

  @derive Jason.Encoder
  defstruct [
    :coverage,
    :weather,
    :intensity,
    :visibility,
    :attributes
  ]

  @type t :: %__MODULE__{
          :coverage => String.t() | nil,
          :weather => String.t() | nil,
          :intensity => String.t() | nil,
          :visibility => ReqNOAA.Model.QuantitativeValue.t(),
          :attributes => [String.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:visibility, :struct, ReqNOAA.Model.QuantitativeValue)
  end
end

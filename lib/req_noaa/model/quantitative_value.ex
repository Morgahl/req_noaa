defmodule ReqNOAA.Model.QuantitativeValue do
  @moduledoc """
  A structured value representing a measurement and its unit of measure. This object is a slighly modified version of the schema.org definition at https://schema.org/QuantitativeValue
  """

  @derive Jason.Encoder
  defstruct [
    :value,
    :maxValue,
    :minValue,
    :unitCode,
    :qualityControl
  ]

  @type t :: %__MODULE__{
          :value => float() | nil,
          :maxValue => float() | nil,
          :minValue => float() | nil,
          :unitCode => String.t() | nil,
          :qualityControl => String.t() | nil
        }

  def decode(value) do
    value
  end
end

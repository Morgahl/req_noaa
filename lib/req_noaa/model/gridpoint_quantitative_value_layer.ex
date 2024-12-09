defmodule ReqNOAA.Model.GridpointQuantitativeValueLayer do
  @moduledoc """
  A gridpoint layer consisting of quantitative values (numeric values with associated units of measure).
  """

  @derive Jason.Encoder
  defstruct [
    :uom,
    :values
  ]

  @type t :: %__MODULE__{
          :uom => String.t() | nil,
          :values => [ReqNOAA.Model.GridpointQuantitativeValueLayerValuesInner.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:values, :list, ReqNOAA.Model.GridpointQuantitativeValueLayerValuesInner)
  end
end

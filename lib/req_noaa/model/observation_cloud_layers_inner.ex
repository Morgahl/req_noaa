defmodule ReqNOAA.Model.ObservationCloudLayersInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :base,
    :amount
  ]

  @type t :: %__MODULE__{
          :base => ReqNOAA.Model.QuantitativeValue.t(),
          :amount => ReqNOAA.Model.MetarSkyCoverage.t()
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:base, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:amount, :struct, ReqNOAA.Model.MetarSkyCoverage)
  end
end

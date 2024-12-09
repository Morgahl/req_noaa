defmodule ReqNOAA.Model.RelativeLocationJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :city,
    :state,
    :distance,
    :bearing,
    :geometry
  ]

  @type t :: %__MODULE__{
          :city => String.t() | nil,
          :state => String.t() | nil,
          :distance => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :bearing => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :geometry => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:distance, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:bearing, :struct, ReqNOAA.Model.QuantitativeValue)
  end
end

defmodule ReqNOAA.Model.PointRelativeLocation do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :id,
    :type,
    :geometry,
    :properties,
    :city,
    :state,
    :distance,
    :bearing
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :id => String.t() | nil,
          :type => String.t(),
          :geometry => String.t() | nil,
          :properties => ReqNOAA.Model.RelativeLocation.t(),
          :city => String.t() | nil,
          :state => String.t() | nil,
          :distance => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :bearing => ReqNOAA.Model.QuantitativeValue.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.RelativeLocation)
    |> Model.deserialize(:distance, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:bearing, :struct, ReqNOAA.Model.QuantitativeValue)
  end
end

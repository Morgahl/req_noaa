defmodule ReqNOAA.Model.GridpointForecastJsonLd do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :units,
    :forecastGenerator,
    :generatedAt,
    :updateTime,
    :validTimes,
    :elevation,
    :periods
  ]

  @type t :: %__MODULE__{
          :"@context" => any(),
          :geometry => String.t() | nil,
          :units => String.t() | nil,
          :forecastGenerator => String.t() | nil,
          :generatedAt => DateTime.t() | nil,
          :updateTime => DateTime.t() | nil,
          :validTimes => String.t() | nil,
          :elevation => ReqNOAA.Model.QuantitativeValue.t() | nil,
          :periods => [ReqNOAA.Model.GridpointForecastPeriod.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:generatedAt, :datetime, nil)
    |> Model.deserialize(:updateTime, :datetime, nil)
    |> Model.deserialize(:elevation, :struct, ReqNOAA.Model.QuantitativeValue)
    |> Model.deserialize(:periods, :list, ReqNOAA.Model.GridpointForecastPeriod)
  end
end

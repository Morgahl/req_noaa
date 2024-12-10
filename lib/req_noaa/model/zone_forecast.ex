defmodule ReqNOAA.Model.ZoneForecast do
  @moduledoc """
  An object representing a zone area forecast.
  """

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :geometry,
    :zone,
    :updated,
    :periods
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :geometry => String.t() | nil,
          :zone => String.t() | nil,
          :updated => DateTime.t() | nil,
          :periods => [ReqNOAA.Model.ZoneForecastPeriodsInner.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:updated, :datetime, nil)
    |> Model.deserialize(:periods, :list, ReqNOAA.Model.ZoneForecastPeriodsInner)
  end
end

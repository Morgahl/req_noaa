defmodule ReqNOAA.Model.GridpointForecastPeriodWindSpeed do
  @moduledoc """
  Wind speed for the period. This property as an string value is deprecated. Future versions will express this value as a quantitative value object. To make use of the future standard format now, set the \"forecast_wind_speed_qv\" feature flag on the request.
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

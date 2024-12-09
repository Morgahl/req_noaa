defmodule ReqNOAA.Model.GridpointForecastPeriodTemperature do
  @moduledoc """
  High/low temperature for the period, depending on whether the period is day or night. This property as an integer value is deprecated. Future versions will express this value as a quantitative value object. To make use of the future standard format now, set the \"forecast_temperature_qv\" feature flag on the request.
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

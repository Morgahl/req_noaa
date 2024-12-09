defmodule ReqNOAA.Model.ZoneForecastPeriodsInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :number,
    :name,
    :detailedForecast
  ]

  @type t :: %__MODULE__{
          :number => integer(),
          :name => String.t(),
          :detailedForecast => String.t()
        }

  def decode(value) do
    value
  end
end

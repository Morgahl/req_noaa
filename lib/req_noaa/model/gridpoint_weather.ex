defmodule ReqNOAA.Model.GridpointWeather do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :values
  ]

  @type t :: %__MODULE__{
          :values => [ReqNOAA.Model.GridpointWeatherValuesInner.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:values, :list, ReqNOAA.Model.GridpointWeatherValuesInner)
  end
end

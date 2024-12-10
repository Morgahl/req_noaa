defmodule ReqNOAA.Model.GridpointWeatherValuesInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :validTime,
    :value
  ]

  @type t :: %__MODULE__{
          :validTime => String.t(),
          :value => [ReqNOAA.Model.GridpointWeatherValuesInnerValueInner.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:value, :list, ReqNOAA.Model.GridpointWeatherValuesInnerValueInner)
  end
end

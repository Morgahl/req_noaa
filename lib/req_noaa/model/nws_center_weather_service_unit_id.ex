defmodule ReqNOAA.Model.NwsCenterWeatherServiceUnitId do
  @moduledoc """
  Three-letter identifier for a Center Weather Service Unit (CWSU).
  """

  @derive Jason.Encoder
  defstruct []

  @type t :: %__MODULE__{}

  def decode(value) do
    value
  end
end

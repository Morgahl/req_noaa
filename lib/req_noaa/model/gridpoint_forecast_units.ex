defmodule ReqNOAA.Model.GridpointForecastUnits do
  @moduledoc """
  Denotes the units used in the textual portions of the forecast.
  """

  @derive Jason.Encoder
  defstruct []

  @type t :: %__MODULE__{}

  def decode(value) do
    value
  end
end

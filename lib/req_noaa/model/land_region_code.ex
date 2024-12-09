defmodule ReqNOAA.Model.LandRegionCode do
  @moduledoc """
  Land region code. These correspond to the six NWS regional headquarters: * AR: Alaska Region * CR: Central Region * ER: Eastern Region * PR: Pacific Region * SR: Southern Region * WR: Western Region
  """

  @derive Jason.Encoder
  defstruct []

  @type t :: %__MODULE__{}

  def decode(value) do
    value
  end
end

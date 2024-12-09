defmodule ReqNOAA.Model.NwsNationalHqid do
  @moduledoc """
  Three-letter identifier for NWS National HQ.
  """

  @derive Jason.Encoder
  defstruct []

  @type t :: %__MODULE__{}

  def decode(value) do
    value
  end
end

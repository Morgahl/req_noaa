defmodule ReqNOAA.Model.NwsRegionalHqid do
  @moduledoc """
  Three-letter identifier for a NWS Regional HQ.
  """

  @derive Jason.Encoder
  defstruct []

  @type t :: %__MODULE__{}

  def decode(value) do
    value
  end
end

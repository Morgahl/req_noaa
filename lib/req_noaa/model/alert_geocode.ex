defmodule ReqNOAA.Model.AlertGeocode do
  @moduledoc """
  Lists of codes for NWS public zones and counties affected by the alert.
  """

  @derive Jason.Encoder
  defstruct [
    :UGC,
    :SAME
  ]

  @type t :: %__MODULE__{
          :UGC => [String.t()] | nil,
          :SAME => [String.t()] | nil
        }

  def decode(value) do
    value
  end
end

defmodule ReqNOAA.Model.MetarPhenomenon do
  @moduledoc """
  An object representing a decoded METAR phenomenon string.
  """

  @derive Jason.Encoder
  defstruct [
    :intensity,
    :modifier,
    :weather,
    :rawString,
    :inVicinity
  ]

  @type t :: %__MODULE__{
          :intensity => String.t() | nil,
          :modifier => String.t() | nil,
          :weather => String.t(),
          :rawString => String.t(),
          :inVicinity => boolean() | nil
        }

  def decode(value) do
    value
  end
end

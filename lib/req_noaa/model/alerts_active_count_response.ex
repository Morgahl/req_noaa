defmodule ReqNOAA.Model.AlertsActiveCountResponse do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :total,
    :land,
    :marine,
    :regions,
    :areas,
    :zones
  ]

  @type t :: %__MODULE__{
          :total => integer() | nil,
          :land => integer() | nil,
          :marine => integer() | nil,
          :regions => %{optional(String.t()) => integer()} | nil,
          :areas => %{optional(String.t()) => integer()} | nil,
          :zones => %{optional(String.t()) => integer()} | nil
        }

  def decode(value) do
    value
  end
end

defmodule ReqNOAA.Model.AlertXmlParameter do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :valueName,
    :value
  ]

  @type t :: %__MODULE__{
          :valueName => String.t() | nil,
          :value => String.t() | nil
        }

  def decode(value) do
    value
  end
end

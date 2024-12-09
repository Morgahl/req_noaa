defmodule ReqNOAA.Model.AlertsTypesResponse do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :eventTypes
  ]

  @type t :: %__MODULE__{
          :eventTypes => [String.t()] | nil
        }

  def decode(value) do
    value
  end
end

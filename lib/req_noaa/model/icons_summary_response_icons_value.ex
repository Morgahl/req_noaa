defmodule ReqNOAA.Model.IconsSummaryResponseIconsValue do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :description
  ]

  @type t :: %__MODULE__{
          :description => String.t()
        }

  def decode(value) do
    value
  end
end

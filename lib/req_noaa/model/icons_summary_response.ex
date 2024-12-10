defmodule ReqNOAA.Model.IconsSummaryResponse do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :icons
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :icons => %{optional(String.t()) => ReqNOAA.Model.IconsSummaryResponseIconsValue.t()}
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:icons, :map, ReqNOAA.Model.IconsSummaryResponseIconsValue)
  end
end

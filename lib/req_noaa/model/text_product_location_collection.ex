defmodule ReqNOAA.Model.TextProductLocationCollection do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :locations
  ]

  @type t :: %__MODULE__{
          :"@context" => ReqNOAA.Model.JsonLdContext.t() | nil,
          :locations => %{optional(String.t()) => String.t()} | nil
        }

  def decode(value) do
    value
  end
end

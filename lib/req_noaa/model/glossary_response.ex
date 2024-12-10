defmodule ReqNOAA.Model.GlossaryResponse do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :glossary
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :glossary => [ReqNOAA.Model.GlossaryResponseGlossaryInner.t()] | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:glossary, :list, ReqNOAA.Model.GlossaryResponseGlossaryInner)
  end
end

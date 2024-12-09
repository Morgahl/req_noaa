defmodule ReqNOAA.Model.GlossaryResponseGlossaryInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :term,
    :definition
  ]

  @type t :: %__MODULE__{
          :term => String.t() | nil,
          :definition => String.t() | nil
        }

  def decode(value) do
    value
  end
end

defmodule ReqNOAA.Model.TextProductTypeCollectionGraphInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :productCode,
    :productName
  ]

  @type t :: %__MODULE__{
          :productCode => String.t(),
          :productName => String.t()
        }

  def decode(value) do
    value
  end
end

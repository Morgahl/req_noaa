defmodule ReqNOAA.Model.OfficeAddress do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@type",
    :streetAddress,
    :addressLocality,
    :addressRegion,
    :postalCode
  ]

  @type t :: %__MODULE__{
          :"@type" => String.t() | nil,
          :streetAddress => String.t() | nil,
          :addressLocality => String.t() | nil,
          :addressRegion => String.t() | nil,
          :postalCode => String.t() | nil
        }

  def decode(value) do
    value
  end
end

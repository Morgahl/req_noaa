defmodule ReqNOAA.Model.AlertReferencesInner do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@id",
    :identifier,
    :sender,
    :sent
  ]

  @type t :: %__MODULE__{
          :"@id" => String.t() | nil,
          :identifier => String.t() | nil,
          :sender => String.t() | nil,
          :sent => DateTime.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:sent, :datetime, nil)
  end
end

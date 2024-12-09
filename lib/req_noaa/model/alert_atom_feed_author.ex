defmodule ReqNOAA.Model.AlertAtomFeedAuthor do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :name
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil
        }

  def decode(value) do
    value
  end
end

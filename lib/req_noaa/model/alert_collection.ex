defmodule ReqNOAA.Model.AlertCollection do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :title,
    :updated,
    :pagination
  ]

  @type t :: %__MODULE__{
          :title => String.t() | nil,
          :updated => DateTime.t() | nil,
          :pagination => ReqNOAA.Model.PaginationInfo.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:updated, :datetime, nil)
    |> Model.deserialize(:pagination, :struct, ReqNOAA.Model.PaginationInfo)
  end
end

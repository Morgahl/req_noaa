defmodule ReqNOAA.Model.PaginationInfo do
  @moduledoc """
  Links for retrieving more data from paged data sets
  """

  @derive Jason.Encoder
  defstruct [
    :next
  ]

  @type t :: %__MODULE__{
          :next => String.t()
        }

  def decode(value) do
    value
  end
end

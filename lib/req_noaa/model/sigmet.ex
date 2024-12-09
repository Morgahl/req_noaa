defmodule ReqNOAA.Model.Sigmet do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :id,
    :issueTime,
    :fir,
    :atsu,
    :sequence,
    :phenomenon,
    :start,
    :end
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :issueTime => DateTime.t() | nil,
          :fir => String.t() | nil,
          :atsu => String.t() | nil,
          :sequence => String.t() | nil,
          :phenomenon => String.t() | nil,
          :start => DateTime.t() | nil,
          :end => DateTime.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:issueTime, :datetime, nil)
    |> Model.deserialize(:start, :datetime, nil)
    |> Model.deserialize(:end, :datetime, nil)
  end
end

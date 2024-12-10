defmodule ReqNOAA.Model.CenterWeatherAdvisory do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :id,
    :issueTime,
    :cwsu,
    :sequence,
    :start,
    :end,
    :observedProperty,
    :text
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :issueTime => DateTime.t() | nil,
          :cwsu => String.t() | nil,
          :sequence => integer() | nil,
          :start => DateTime.t() | nil,
          :end => DateTime.t() | nil,
          :observedProperty => String.t() | nil,
          :text => String.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:issueTime, :datetime, nil)
    |> Model.deserialize(:start, :datetime, nil)
    |> Model.deserialize(:end, :datetime, nil)
  end
end

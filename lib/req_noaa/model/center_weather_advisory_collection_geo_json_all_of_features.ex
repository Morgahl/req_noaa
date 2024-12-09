defmodule ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJsonAllOfFeatures do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :properties
  ]

  @type t :: %__MODULE__{
          :properties => ReqNOAA.Model.CenterWeatherAdvisory.t() | nil
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:properties, :struct, ReqNOAA.Model.CenterWeatherAdvisory)
  end
end

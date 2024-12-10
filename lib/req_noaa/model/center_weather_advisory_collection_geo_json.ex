defmodule ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJson do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :"@context",
    :type,
    :features
  ]

  @type t :: %__MODULE__{
          :"@context" => any() | nil,
          :type => String.t(),
          :features => [ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJsonAllOfFeatures.t()]
        }

  alias ReqNOAA.Model

  def decode(value) do
    value
    |> Model.deserialize(:features, :list, ReqNOAA.Model.CenterWeatherAdvisoryCollectionGeoJsonAllOfFeatures)
  end
end
